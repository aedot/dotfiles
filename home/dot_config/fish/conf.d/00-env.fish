set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx KUBE_EDITOR nvim
set -gx GOPATH $HOME/.go
set -gx LANG en_US.UTF-8
set -gx SOPS_AGE_KEY_FILE $HOME/.sops/age.agekey
status is-interactive; and set -gx GPG_TTY (tty)

# Use a separate, named history session inside Ghostty.
if set -q GHOSTTY_RESOURCES_DIR
    set -gx fish_history ghostty
end

fish_add_path --global $HOME/.local/bin
fish_add_path --global $HOME/.krew/bin
fish_add_path --global $GOPATH/bin
