#!/usr/bin/env bash
# Shell tools: bash, tmux, fzf, zellij, xclip, less, tmate, screen

CATEGORY="shell"
DESCRIPTION="Shell & terminal tools (tmux, fzf, zellij, xclip)"

install() {
    apt_install tmux fzf screen

    # Install tpm (Tmux Plugin Manager) if not present
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        info "Cloning Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
        ok "tpm installed"
    else
        ok "tpm already present"
    fi
}

post_install() {
    # Stow tmux package to create .tmux.conf symlink
    stow_package tmux

    # Stow less package
    stow_package less || true

    # Install tmux plugins via tpm
    if [ -f "$HOME/.tmux/plugins/tpm/tpm" ]; then
        info "Installing tmux plugins..."
        "$HOME/.tmux/plugins/tpm/bin/install_plugins" 2>/dev/null || \
            info "Plugins will be installed on first tmux launch (prefix + I)"
    fi
}
