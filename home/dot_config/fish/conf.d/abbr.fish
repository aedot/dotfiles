# Aliases and abbreviations. Sourced after the numbered files, so Homebrew/mise
# are already on PATH and the `type -q` guards below see the installed tools.

# --- ls with color (GNU vs BSD) ---
if ls --color=auto >/dev/null 2>&1
    alias ll 'ls -lh --color=auto'
    alias la 'ls -lha --color=auto'
    alias l 'ls -CF --color=auto'
else
    set -gx CLICOLOR 1
    alias ll 'ls -lhG'
    alias la 'ls -lhaG'
    alias l 'ls -CFG'
end

# --- Core utilities ---
abbr -a -- .. 'cd ..'
abbr -a -- ... 'cd ../..'
alias c 'clear'
alias grep 'grep --color=auto'

if type -q chezmoi
    abbr cm chezmoi
end

# --- Git ---
if type -q git
    abbr g git
    abbr gs 'git status'
    abbr ga 'git add'
    abbr gaa 'git add -A'
    abbr gb 'git branch'
    abbr gc 'git commit -v'
    abbr gcm 'git commit -m'
    abbr gco 'git checkout'
    abbr gcb 'git checkout -b'
    abbr gd 'git diff'
    abbr gds 'git diff --staged'
    abbr gl 'git log --oneline --graph --decorate'
    abbr gp 'git push'
    abbr gpl 'git pull'
    abbr gcl 'git clone'
    abbr gst 'git stash'
    abbr gstp 'git stash pop'
    abbr gundo 'git reset --soft HEAD~1'
end

# --- Docker ---
if type -q docker
    abbr d docker
    abbr dps 'docker ps'
    abbr dpa 'docker ps -a'
    abbr di 'docker images'
    abbr drm 'docker rm -f'
    abbr drmi 'docker rmi'
    abbr dstop 'docker stop (docker ps -q)'
    abbr dexec 'docker exec -it'
    abbr dlogs 'docker logs -f'
end

# --- Kubernetes ---
if type -q kubectl
    abbr k kubectl
    abbr kgp 'kubectl get pods'
    abbr kgs 'kubectl get svc'
    abbr kgd 'kubectl get deployments'
    abbr kctx 'kubectl config current-context'
    abbr kctxs 'kubectl config get-contexts'
    abbr kns 'kubectl config set-context --current --namespace'
end

# --- Helm ---
if type -q helm
    abbr hm helm
    abbr hl 'helm list'
    abbr hi 'helm install'
    abbr hu 'helm upgrade'
    abbr hr 'helm repo update'
    abbr hsearch 'helm search repo'
end

# --- Talosctl ---
if type -q talosctl
    abbr t talosctl
    abbr tget 'talosctl get'
    abbr tapply 'talosctl apply'
    abbr tlogs 'talosctl logs'
    abbr treboot 'talosctl reboot'
end

# --- Misc ---
if type -q akeyless
    abbr ak akeyless
end

alias py 'python3'
alias pip 'pip3'
alias serve 'python3 -m http.server'
alias ports 'sudo lsof -i -P -n | grep LISTEN'
alias path 'string join \n -- $PATH'
alias reload 'exec fish'
