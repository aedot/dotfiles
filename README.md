## A Fresh OS X Setup

Follow these install instructions to setup a new Mac.

1. Update OS X to the latest version with the App Store
2. Install Xcode from the App Store, open it and accept the license agreement
3. Install OS X Command Line Tools
4. Generate and copy SSH keys to github `ssh-keygen -t ed25519 -C "your_email@example.com"`
5. Ensure SSH agent is running `eval "$(ssh-agent -s)"`
6. Test SSH connection `ssh -T git@github.com`
7. Verify SSH key is on system `ssh-add -l`
8. If SSH key is not found, add `ssh-add ~/.ssh/sshkey_id`
9. Clone this repo to `~/.dotfiles`
10. Append `/usr/local/bin/zsh` to the end of your `/etc/shells` file
11. Make script executable `chmod +x install.sh`
12. Run `install.sh` to start the installation
13. [Install the remaining apps](./apps.md)
14. Restore preferences by running `mackup restore`
15. Restart your computer to finalize the process

Your Mac is now ready to use!

Check out the [`Brewfile`](./Brewfile) and adjust the apps you want to install for your machine. Use [their search page](hhttps://formulae.brew.sh/cask/) to check if the app you want to install is available.

One thing you'll need to do manually is add your `~/.zshrc` file. You can't symlink the `.zshrc` file from your dotfiles because Mackup will already symlink your `.zshrc` from your home directory. That's why we'll need to create the file manually. Add the contents below to a `.zshrc` file in your user directory. What it will do is load the `.zshrc` file from your dotfiles. Make sure that the path to your dotfiles is correct.

```zsh
# Load Zsh
source ~/.dotfiles/.zshrc
```

> I've thought about backing up the `.zshrc` file entirely to Mackup and removing it from this repo. But I like it to be versioned with the repo so I can use it for documentation and as an example. I also believe that it makes more sense to keep it in this repo because it's pretty tied into this repo's files and settings.

When installing these dotfiles for the first time you'll need to backup all of your settings with Mackup. Install and backup your settings with the command below. Your settings will be synced to your Dropbox so you can use them to sync between computers and reinstall them when reinstalling your Mac. If you want to save your settings to a different folder or different medium than Dropbox, [checkout the documentation](https://github.com/lra/mackup#supported-storages).

```zsh
brew install mackup
mackup backup
```
