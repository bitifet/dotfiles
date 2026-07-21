#!/usr/bin/env bash
# Node.js via nvm

CATEGORY="node"
DESCRIPTION="Node.js via nvm with npm global packages"

load_nvm() {
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        set +eu  # nvm.sh is not compatible with strict mode
        . "$NVM_DIR/nvm.sh"
        set -eu
    fi
}

install() {
    if [ -d "$HOME/.nvm" ]; then
        ok "nvm already installed"
        load_nvm
        return 0
    fi

    info "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    load_nvm

    info "Installing latest LTS Node..."
    nvm install --lts
    nvm alias default lts/*
}

post_install() {
    load_nvm

    if command -v npm &>/dev/null; then
        info "Installing global npm packages..."
        npm install -g underscore-cli 2>/dev/null || true
    fi
}
