#!/usr/bin/env bash
# Touchpad: enable tap-to-click via libinput

CATEGORY="touchpad"
DESCRIPTION="Enable touchpad tap-to-click"

install() {
    if ! command -v xinput &>/dev/null; then
        apt_install xinput
    fi

    if ! xinput list 2>/dev/null | grep -iq 'touchpad'; then
        info "No touchpad detected, skipping"
        return 0
    fi
}

post_install() {
    local conf_dir="/etc/X11/xorg.conf.d"
    local conf_file="$conf_dir/40-touchpad-tap.conf"

    if [ -f "$conf_file" ]; then
        ok "Touchpad tap-to-click already configured"
        return 0
    fi

    if confirm "Enable tap-to-click for touchpad?"; then
        sudo mkdir -p "$conf_dir"
        sudo tee "$conf_file" > /dev/null <<'EOF'
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lrm"
    Option "NaturalScrolling" "on"
EndSection
EOF
        ok "Touchpad configuration written. Restart X to apply."
    fi
}
