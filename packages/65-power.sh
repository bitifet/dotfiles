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
    local logind_conf="/etc/systemd/logind.conf"
    info "Configuring lid close actions..."

    # Battery: suspend immediately, hibernate after 30 min
    sudo sed -i 's/^#*HandleLidSwitch=.*/HandleLidSwitch=suspend-then-hibernate/' "$logind_conf"
    # AC power: just lock the screen
    sudo sed -i 's/^#*HandleLidSwitchExternalPower=.*/HandleLidSwitchExternalPower=lock/' "$logind_conf"

    ok "Lid close on battery → suspend-then-hibernate"
    ok "Lid close on AC     → lock screen"

    # ---- hibernate delay ----
    local sleep_conf="/etc/systemd/sleep.conf"
    info "Configuring hibernate delay (30 minutes after suspend)..."
    sudo sed -i 's/^#*HibernateDelaySec=.*/HibernateDelaySec=1800/' "$sleep_conf"

    sudo systemctl restart systemd-logind
    ok "Power settings applied"

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
