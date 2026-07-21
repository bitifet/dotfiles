#!/usr/bin/env bash
# Extras: optional tools specific to certain workflows or machines

CATEGORY="extras"
DESCRIPTION="Optional extras (imagemagick, poppler, python tools, powerline)"

install() {
    apt_install imagemagick poppler-utils python3-pip 2>/dev/null || true
}

post_install() {
    # Stow zellij if the package exists (may not want on all machines)
    if confirm "Install zellij config?"; then
        stow_package zellij || true
    fi

    # Optionally install powerline fonts
    if confirm "Install powerline fonts?"; then
        info "Cloning powerline fonts..."
        git clone https://github.com/powerline/fonts.git /tmp/powerline-fonts 2>/dev/null || true
        if [ -d /tmp/powerline-fonts ]; then
            (cd /tmp/powerline-fonts && ./install.sh 2>/dev/null || true)
            rm -rf /tmp/powerline-fonts
        fi
    fi
}
