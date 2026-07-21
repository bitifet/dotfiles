#!/usr/bin/env bash
# Brave browser

CATEGORY="brave"
DESCRIPTION="Brave web browser"

install() {
    if command -v brave-browser &>/dev/null; then
        ok "Brave already installed"
        return 0
    fi

    info "Adding Brave repository..."
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
        https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
        | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt-get update -qq
    apt_install brave-browser
}
