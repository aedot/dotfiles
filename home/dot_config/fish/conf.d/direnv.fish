# Shadows Homebrew's vendor_conf.d/direnv.fish, which hooks via the versioned
# Cellar path. The hook embeds the binary's absolute path, so resolve it via
# PATH instead; otherwise open shells break once an upgrade removes that version.
if status is-interactive; and type -q direnv
    direnv hook fish | string replace -ra '"[^"]*/direnv"' direnv | source
end
