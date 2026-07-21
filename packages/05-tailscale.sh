#!/usr/bin/env bash
# Tailscale: mesh VPN for connecting personal devices

CATEGORY="tailscale"
DESCRIPTION="Tailscale VPN (mesh network for personal devices)"

install() {
    if command -v tailscale &>/dev/null; then
        ok "Tailscale already installed"
        return 0
    fi

    info "Installing Tailscale..."
    curl -fsSL https://tailscale.com/install.sh | sh
}

post_install() {
    if command -v tailscale &>/dev/null; then
        if tailscale status &>/dev/null 2>&1; then
            ok "Tailscale is already running"
            return 0
        fi
        if confirm "Start Tailscale daemon now?"; then
            sudo tailscale up --ssh
        else
            info "Run 'sudo tailscale up' later to connect."
        fi
    fi
}
