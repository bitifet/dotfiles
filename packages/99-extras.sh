#!/usr/bin/env bash
# Extras: optional tools that don't fit elsewhere

CATEGORY="extras"
DESCRIPTION="Optional extras (imagemagick, poppler, powerline fonts)"

install() {
    apt_install imagemagick poppler-utils 2>/dev/null || true
}

post_install() {
    if confirm "Install zellij config symlink?"; then
        stow_package zellij || true
    fi

    if confirm "Install powerline fonts?"; then
        info "Cloning powerline fonts..."
        git clone https://github.com/powerline/fonts.git /tmp/powerline-fonts 2>/dev/null || true
        if [ -d /tmp/powerline-fonts ]; then
            (cd /tmp/powerline-fonts && ./install.sh 2>/dev/null || true)
            rm -rf /tmp/powerline-fonts
        fi
    fi
}
