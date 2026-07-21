#!/usr/bin/env bash
# SSH server + Mosh

CATEGORY="ssh"
DESCRIPTION="SSH server and Mosh (mobile shell)"

install() {
    apt_install openssh-server mosh
}

post_install() {
    if systemctl is-active --quiet ssh 2>/dev/null; then
        ok "SSH server is already running"
        return 0
    fi
    if confirm "Enable SSH server on boot?" "n"; then
        sudo systemctl enable ssh
        sudo systemctl start ssh
        ok "SSH server enabled and started"
    else
        sudo systemctl disable ssh 2>/dev/null || true
        sudo systemctl stop ssh 2>/dev/null || true
        ok "SSH server left disabled"
    fi
}
