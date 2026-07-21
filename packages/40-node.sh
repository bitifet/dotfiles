#!/usr/bin/env bash
# Node.js via nvm

CATEGORY="node"
DESCRIPTION="Node.js via nvm with npm global packages"

install() {
    if [ -d "$HOME/.nvm" ]; then
        ok "nvm already installed"
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
        return 0
    fi

    info "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

    info "Installing latest LTS Node..."
    nvm install --lts
    nvm alias default lts/*
}

post_install() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

    if command -v npm &>/dev/null; then
        info "Installing global npm packages..."
        npm install -g underscore-cli 2>/dev/null || true
    fi
}
