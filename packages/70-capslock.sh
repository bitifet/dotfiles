#!/usr/bin/env bash
# CapsLock -> Escape remap, auto-detecting desktop environment.
# Supports: GNOME, XFCE, generic X11 (setxkbmap).

CATEGORY="capslock"
DESCRIPTION="Remap CapsLock to Escape (auto-detect DE)"

detect_de() {
    if [ -n "${XDG_CURRENT_DESKTOP:-}" ]; then
        echo "${XDG_CURRENT_DESKTOP,,}"
    elif [ -n "${DESKTOP_SESSION:-}" ]; then
        echo "${DESKTOP_SESSION,,}"
    elif pgrep -x gnome-shell &>/dev/null; then
        echo "gnome"
    elif pgrep -x xfdesktop &>/dev/null || pgrep -x xfce4-session &>/dev/null; then
        echo "xfce"
    else
        echo "unknown"
    fi
}

install() {
    :
}

post_install() {
    if ! confirm "Remap CapsLock to Escape?"; then
        return 0
    fi

    local de
    de=$(detect_de)

    case "$de" in
        *gnome*|*ubuntu*)
            info "Detected GNOME. Setting via gsettings..."
            gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
            ok "CapsLock -> Escape (GNOME)"
            ;;
        *xfce*)
            info "Detected XFCE. Setting via xfconf..."
            xfconf-query -c keyboards -p /Default/KeyRepeat -n -t bool -s true 2>/dev/null || true
            # XFCE stores keyboard options in /etc/default/keyboard or via xfce4-keyboard-settings
            # Use setxkbmap + autostart as fallback
            local autostart_dir="$HOME/.config/autostart"
            ensure_dir "$autostart_dir"
            cat > "$autostart_dir/capslock-remap.desktop" <<'DESKTOP'
[Desktop Entry]
Type=Application
Name=CapsLock Remap
Exec=setxkbmap -option caps:swapescape
Hidden=false
NoDisplay=true
X-GNOME-Autostart-enabled=true
DESKTOP
            ok "CapsLock -> Escape (XFCE autostart)"
            ;;
        *)
            info "Desktop not detected. Using setxkbmap..."
            if command -v setxkbmap &>/dev/null; then
                setxkbmap -option caps:swapescape
                ok "CapsLock -> Escape (setxkbmap, current session only)"
                warn "Add 'setxkbmap -option caps:swapescape' to your startup programs."
            else
                warn "setxkbmap not available. Install it: sudo apt install x11-xkb-utils"
            fi
            ;;
    esac
}
