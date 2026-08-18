#!/usr/bin/env bash
set -euo pipefail
# Bootstrap mise before files are applied so the after-hook can read the config.
# Selected via .chezmoiignore (linux only).
if ! command -v mise >/dev/null && [ ! -x "$HOME/.local/bin/mise" ]; then
    curl -fsSL https://mise.run | sh
fi
