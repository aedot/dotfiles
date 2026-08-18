# dotfiles

My personal dotfiles, managed by [chezmoi](https://www.chezmoi.io/).

## Machines

| Machine  | Device         | Shell | Packages |
| -------- | -------------- | ----- | -------- |
| `darwin` | macOS          | fish  | Homebrew |
| `linux`  | Linux          | fish  | mise     |

`chezmoi init` derives the machine from the OS name (`darwin` on macOS, `linux`
elsewhere) and stores it as `machine` in the local chezmoi config. Everything
else keys off that value: [`.chezmoiignore`](home/.chezmoiignore) selects which
files and scripts apply per machine, and
[`.chezmoidata/packages.yaml`](home/.chezmoidata/packages.yaml) is the single
declarative source for every package. The content files themselves stay free of
machine conditionals.

## Layout

```
home/
  .chezmoi.yaml.tmpl              # machine detection + name/email prompt (once)
  .chezmoidata/packages.yaml      # all packages: brew (darwin) + mise (linux)
  .chezmoiignore                  # per-machine file/script selection
  .chezmoiscripts/                # hash-gated install hooks (run_onchange)
    run_once_before_install-mise.sh
    run_onchange_after_brew-bundle.sh.tmpl
    run_onchange_after_mise-install.sh.tmpl
    run_onchange_after_update-fisher.sh.tmpl
  dot_config/
    fish/                         # config.fish + numbered conf.d/ + functions/
    homebrew/brewfile.tmpl        # generated from packages.yaml (darwin)
    mise/config.toml.tmpl         # generated from packages.yaml (linux)
    ghostty/config, starship.toml, .macos
  dot_gitconfig.tmpl, dot_gitignore_global
  private_dot_ssh/private_config
```

Adding or removing a package is a one-line edit to `packages.yaml`; the templated
brewfile / mise config regenerate, and the hash-gated hook reinstalls on the next
`chezmoi apply`.

## Bootstrap

### darwin

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi
chezmoi init --apply aedot/dotfiles
```

The brew-bundle hook installs everything in the brewfile on first apply.
Afterwards, make fish the login shell:

```sh
echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/fish"
```

Optional macOS system defaults (review before running — it changes a lot):

```sh
sh ~/.config/.macos
```

### linux

Install chezmoi to `~/.local/bin` with the official script; mise is bootstrapped
automatically and the declared tools are installed during the first apply.

```sh
sh -c "$(curl -fsSL get.chezmoi.io)" -- -b "$HOME/.local/bin" init --apply aedot/dotfiles
```

Base tools (`fish`, `git`, `coreutils`) come from the distro package manager;
mise supplies the rest (see the `mise.linux` list in `packages.yaml`). Make fish
the login shell once it is installed:

```sh
echo "$(command -v fish)" | sudo tee -a /etc/shells
chsh -s "$(command -v fish)"
```

### Fish plugins

`~/.config/fish/fish_plugins` is managed by chezmoi, and the `update-fisher` hook
bootstraps [fisher](https://github.com/jorgebucaran/fisher) and re-runs
`fisher update` whenever the plugin list changes.

### Secrets

Secrets are decrypted with [age](https://age-encryption.org/) via
`SOPS_AGE_KEY_FILE` (`~/.sops/age.agekey`). Place the key there before running
`chezmoi apply` on a machine that needs encrypted files.

## Development

Edit dotfiles in the chezmoi source (`~/.local/share/chezmoi`), not the rendered
files in `$HOME`:

```sh
chezmoi edit ~/.config/fish/config.fish
chezmoi diff          # preview pending changes
chezmoi apply -v      # apply them
```

Run `chezmoi init` once after pulling changes that touch machine detection so the
local config regenerates before `apply`.
