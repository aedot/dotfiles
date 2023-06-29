# Macbook Pro dotfiles and setup

This repository contains everything to bootstrap my Macbook Pro.

- Current: Macbook Pro 14 inch, M1 Max, 32 GB RAM, 2021 M1 Silicon architecture.

The current ZSH theme is [Powerlevel10k, detailed in this blog post](https://dnsmichi.at/2022/03/11/new-zsh-theme-on-macos-powerlevel10k/).

In addition to the files stored in this repository, the following instructions are needed to fully setup a Macbook Pro.

## Preparations

### warp

Install warp manually from the [website](https://www.warp.dev), drag it into the Applications folder, start it and add it to the deck.

Powerlevel10k fonts for Oh-My-ZSH terminal:

1. Download the font files from https://github.com/romkatv/powerlevel10k#manual-font-installation (backup in [fonts/](fonts/)). 
1. Double-click to open them all to follow "Install Font".

### Git (XCode)

Install it on the command line first, it will ask for permission.

```
xcode-select --install
```

### Sudo

```
sudo vim /private/etc/sudoers.d/aedot

aedot  ALL=(ALL) NOPASSWD: ALL
```

### Backup

Use Google drive and Chrome profile sync to migrate backup data.

Copy the following private secret files in your home directory:

* SSH Keys
* GPG Keys
* GitHub/GitLab Tokens in `.env`
* Custom settings for OhMyZSH

```
cd backup/
cp -r .ssh .gnupg .env .oh-my-zsh $HOME/
```

> **Note**:
>
> The `dotenv` plugin is enabled in OhMyZSH which automatically
> reads the `.env` tokens from the user's home directory.

### Dot files

These steps contain all the remaining setup steps: Homebrew, macOS system settings, applications. 

```
git clone https://github.com/aedot/dotfiles.git
cd dotfiles
```

Sync the files into the home directory.

```
./bootstrap.sh
```

Apply macOS settings. Review the file before applying.

```
./.macos
```

Install Homebrew and OhMyZSH.

```
./brew_once.sh
```

### Install tools and apps

Install tools and applications with Homebrew bundle.

```
brew bundle
```

This makes use of the [Brewfile](Brewfile) definitions.

[mas](https://github.com/mas-cli/mas) is used to install apps from the app store, and is itself installed with Homebrew first in the [Brewfile](Brewfile).

```
$ cat Brewfile

brew "mas"

...
mas "Slack", id: 803453959
```

**Note:** [GitLab uses Jamf for endpoint management](https://about.gitlab.com/handbook/business-technology/end-user-services/onboarding-access-requests/endpoint-management/jamf/) which provides a self-service application to manage essential apps. Since 2023-06, I am using this method in favor of Homebrew mas.

## Essentials

These tools are managed outside of Homebrew, and require additional work and documentation.

- [Bitwarden](https://itunes.apple.com/app/bitwarden/id1352778147)
= [Zoom](https://zoom.us/download)
- Java 18+ Open Source

### Tools

#### asdf

[asdf](https://asdf-vm.com/) is installed with [Homebrew](Brewfile) and helps manage different programming languages and environments.

NodeJS:
```
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf list all nodejs
asdf install nodejs 20.3.0
asdf local nodejs 20.3.0
```

#### Firefox


#### Raycast Extensions

Open the extensions and record keyboard shortcut commands. I use the emoji search very extensively, and have recorded cmd + ` for faster access.

## Settings

These are manual settings as they require user awareness.

### FileVault

Enable Encryption ([required for GitLab team members with Jamf](https://about.gitlab.com/handbook/business-technology/end-user-services/onboarding-access-requests/endpoint-management/jamf/#why-jamf).
See [here](https://support.apple.com/en-us/HT204837) for detailed instructions.


### Keyboard

`Settings > Keyboard > Keyboard Shortcuts`:

1. Disable all Spotlight options in preparation for enabling Raycast as default shortcut using `cmd + space`.

### Raycast

Start Raycast from the Applications folder in Finder, and change the hotkey to `Cmd+Space`.
Ensure that Spotlight is disabled in the system preferences.

### Finder

Open Finder and navigate into `Settings > Sidebar` to add

- User home (user name)
- System root (Macbook name)

### Zoom

https://handbook.gitlab.com/handbook/tools-and-tips/zoom/

`Settings > General`: Untick `Ask me to confirm when I leave a metting`
`Settings > Audio`: Mute my mic when joining
`Settings > Keyboard Shortcuts`: Mute/Unmute my audio: `cmd 1`.

## Additional Applications

* Google Chrome
* JetBrains Toolbox (license required)
* NTFS for Mac (license required, I own a private license)
* Spotify (account required)
* Telegram (account required)

### Handbook

Following the [GitLab tools and tipshandbook](https://handbook.gitlab.com/handbook/tools-and-tips/).


### Homebrew

Managed as casks in [Brewfile](Brewfile).

* Firefox (in order to reproduce UX bugs)
* VLC
* Wireshark


## Additional Hints

### Other projects

More insights can be found in these lists:

- [Setting examples](https://github.com/mathiasbynens/dotfiles/blob/master/.macos)
- [macos Ventura settings](https://github.com/gretzky/dotfiles/blob/main/macos/.macos)
- [command overview](https://github.com/herrbischoff/awesome-macos-command-line).

## Upgrades


### Homebrew 

### Oh-my-ZSH and Themes

```
cd ~/.oh-my-zsh
git pull

cd ~/.oh-my-zsh/custom/themes/powerlevel10k
git pull
```

### Troubleshooting

On major version upgrades, binaries might be incompatible or need a local rebuild. 
You can enforce a reinstall by running the two commands below, the second command
only reinstalls all application casks.

```
brew reinstall $(brew list)

brew reinstall $(brew list --cask)
```

When Xcode and compilers break, re-install the command line tools.

```
sudo rm -rf /Library/Developer/CommandLineTools
sudo xcode-select --install
```

### Git xcrun errors on macOS Ventura upgrades

```
xcrun: error: invalid active developer path
```

You need to explicity agree to the terms of services for the developer tools.

```
xcode-select --install
```

### Settings do not work after upgrades

The settings in [.macos](.macos) use macOS internal APIs on the command line. Sometimes the configuration settings change, for example with the Trackpad on macOs Ventura.

To debug and capture which settings are in effect, create a new Git repository somewhere, and persist the system settings output.

```
mkdir $HOME/dev/work/system-settings
cd $HOME/dev/work/system-settings
git init

defaults read > settings.txt

git add settings.txt
git commit -av -m "Initial settings"
```

Then navigate into the Systems settings GUI, change parameters, export the system settings into the same file, and analyze the Git diff to figure out the correct parameter names and values.

```
defaults read > settings.txt

git diff
```

Example with Trackpad and right-click:

```diff
     "com.apple.AppleMultitouchTrackpad" =     {
         ActuateDetents = 1;
-        Clicking = 0;
+        Clicking = 1;
         DragLock = 0;
         Dragging = 0;
         FirstClickThreshold = 1;
         ForceSuppressed = 0;
         SecondClickThreshold = 1;
-        TrackpadCornerSecondaryClick = 0;
+        TrackpadCornerSecondaryClick = 2;
         TrackpadFiveFingerPinchGesture = 2;
         TrackpadFourFingerHorizSwipeGesture = 2;
         TrackpadFourFingerPinchGesture = 2;
@@ -463,7 +464,7 @@
         TrackpadHorizScroll = 1;
         TrackpadMomentumScroll = 1;
         TrackpadPinch = 1;
-        TrackpadRightClick = 1;
+        TrackpadRightClick = 0;
         TrackpadRotate = 1;
         TrackpadScroll = 1;
         TrackpadThreeFingerDrag = 0;
```

Requiring the current settings to be changed to https://gitlab.com/dnsmichi/dotfiles/-/commit/f16809989ba2d65fc73e1274356b6f2c6cfde1db in June 2023.

### Touch ID does not work

The magic keyboard with Touch ID does not work after the Macbook went to sleep.

- https://www.reddit.com/r/mac/comments/13hd4aa/magic_keyboard_with_touch_id_no_working_after/
- https://www.reddit.com/r/macmini/comments/12cw4mf/touch_id_issues_on_mac_mini_m2/ 
- https://support.apple.com/en-us/HT212225#:~:text=For%20Magic%20Keyboard%20with%20Touch,Restart%20your%20Mac 