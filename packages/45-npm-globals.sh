#!/usr/bin/env bash
# npm global packages (agentp, carlino, etc.)
# Run this whenever you install a new Node version via nvm.

CATEGORY="npm-globals"
DESCRIPTION="npm global packages (agentp, carlino)"

install() {
    if ! command -v npm &>/dev/null; then
        err "npm not found. Install Node.js first (40-node.sh)."
        return 1
    fi

    npm install -g agentp
    npm install -g carlino
    ok "Global npm packages installed"
}
