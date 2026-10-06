#!/usr/bin/env bash
# Power management: lid close actions, suspend-then-hibernate

CATEGORY="power"
DESCRIPTION="Lid close: suspend-then-hibernate (battery) / lock (AC)"

install() {
    :
}

post_install() {
    if ! confirm "Configure power management (lid close, suspend/hibernate)?"; then
        return 0
    fi

    # ---- lid close behaviour ----
    # Use a systemd-logind drop-in instead of editing /etc/systemd/logind.conf,
    # so OS updates never clobber our settings.
    local logind_dropin="/etc/systemd/logind.conf.d/99-dotfiles.conf"
    info "Configuring lid close actions (logind.conf.d drop-in)..."
    sudo mkdir -p "$(dirname "$logind_dropin")"
    sudo tee "$logind_dropin" > /dev/null <<'EOF'
[Login]
# Battery: suspend immediately, hibernate after 30 min
HandleLidSwitch=suspend-then-hibernate
# AC power: just lock the screen
HandleLidSwitchExternalPower=lock
EOF

    ok "Lid close on battery → suspend-then-hibernate"
    ok "Lid close on AC     → lock screen"

    # ---- hibernate delay ----
    # Use a systemd-sleep drop-in instead of editing /etc/systemd/sleep.conf.
    local sleep_dropin="/etc/systemd/sleep.conf.d/99-dotfiles.conf"
    info "Configuring hibernate delay (30 minutes after suspend)..."
    sudo mkdir -p "$(dirname "$sleep_dropin")"
    sudo tee "$sleep_dropin" > /dev/null <<'EOF'
[Sleep]
HibernateDelaySec=1800
EOF

    sudo systemctl restart systemd-logind
    ok "Power settings applied via drop-in files"

    # ---- hibernation instructions ----
    echo ""
    step "Testing hibernation"
    echo ""
    echo "  Test that hibernation works:"
    echo "    sudo systemctl hibernate"
    echo ""
    echo "  If it fails, your swap may be too small."
    echo "  Check swap size:  swapon --show"
    echo "  Swap must be >= RAM for reliable hibernation."
    echo ""
    echo "  To adjust swap:"
    echo "    sudo swapoff /swapfile"
    echo "    sudo fallocate -l 16G /swapfile  # adjust to your RAM size"
    echo "    sudo mkswap /swapfile"
    echo "    sudo swapon /swapfile"
    echo ""
    echo "  Then add to /etc/fstab:"
    echo "    /swapfile none swap sw 0 0"
    echo ""
}
