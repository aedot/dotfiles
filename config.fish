if status is-interactive
    # Commands to run in interactive sessions can go here

    # Alias
    alias g='git'
    alias gst='git status'

    alias ap='ansible-playbook'
    alias av='ansible-vault'

    alias k='kubectl'
    alias h='helm'

    # Fish startup upon initiation
    starship init fish | source
end

functions --copy fish_prompt fish_prompt_orig; function fish_prompt; fish_prompt_orig; echo; end
