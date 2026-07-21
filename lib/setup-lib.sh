#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
STOW_DIR="$DOTFILES/stow"

# ---- Logging ----
info()  { echo "  [INFO] $*"; }
warn()  { echo "  [WARN] $*" >&2; }
err()   { echo "  [ERROR] $*" >&2; }
step()  { echo "==> $*"; }
ok()    { echo "  [OK] $*"; }

# ---- User interaction ----
confirm() {
    local prompt="${1:-Continue?}"
    local default="${2:-y}"
    if [ "$default" = "y" ]; then
        read -r -p "$prompt [Y/n] " reply
        [ "${reply,,}" != "n" ]
    else
        read -r -p "$prompt [y/N] " reply
        [ "${reply,,}" = "y" ]
    fi
}

# Prompt user to select from a list using whiptail if available, otherwise text.
select_categories() {
    local title="$1"; shift
    local items=("$@")

    if command -v whiptail &>/dev/null; then
        local args=()
        for item in "${items[@]}"; do
            args+=("$item" "" "ON")
        done
        whiptail --title "$title" --checklist "Select what to install:" \
            20 70 "${#items[@]}" "${args[@]}" 3>&1 1>&2 2>&3
    elif command -v dialog &>/dev/null; then
        local args=()
        for item in "${items[@]}"; do
            args+=("$item" "" "ON")
        done
        dialog --title "$title" --checklist "Select what to install:" \
            20 70 "${#items[@]}" "${args[@]}" 3>&1 1>&2 2>&3
    else
        echo "==> Available categories:"
        for item in "${items[@]}"; do
            echo "    $item"
        done
        echo
        read -r -p "Enter category names to install (space-separated, or 'all'): " selection
        echo "$selection"
    fi
}

# ---- Filesystem helpers ----
ensure_dir() { mkdir -p "$1"; }

symlink() {
    local src="$1"
    local dst="$2"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
            info "Already linked: $dst"
            return 0
        fi
        warn "$dst already exists, backing up to ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi
    ensure_dir "$(dirname "$dst")"
    ln -s "$src" "$dst"
    ok "Linked $dst -> $src"
}

# ---- Apt helpers ----
INSTALL_LOG="$DOTFILES/.install-log"

apt_install() {
    local pkgs=("$@")
    info "Installing: ${pkgs[*]}"
    sudo apt-get update -qq
    sudo apt-get install -y "${pkgs[@]}"
    for pkg in "${pkgs[@]}"; do
        echo "[APT] $pkg" >> "$INSTALL_LOG"
    done
}

# ---- Stow helpers ----
stow_package() {
    local pkg="$1"
    if [ ! -d "$STOW_DIR/$pkg" ]; then
        err "Stow package '$pkg' not found in $STOW_DIR"
        return 1
    fi
    step "Stowing $pkg..."
    stow -v -t "$HOME" -d "$STOW_DIR" "$pkg"
    echo "[STOW] $pkg" >> "$INSTALL_LOG"
}

unstow_package() {
    local pkg="$1"
    step "Unstowing $pkg..."
    stow -v -D -t "$HOME" -d "$STOW_DIR" "$pkg" 2>/dev/null || true
}

# ---- Shell config injection ----
inject_source_line() {
    local target_file="$1"
    local source_line="$2"
    local marker="$3"

    if [ -f "$target_file" ] && grep -qF "$marker" "$target_file" 2>/dev/null; then
        info "$target_file already sources $marker"
        return 0
    fi
    ensure_dir "$(dirname "$target_file")"
    echo "" >> "$target_file"
    echo "# DotFiles Setup: $marker" >> "$target_file"
    echo "$source_line" >> "$target_file"
    ok "Added source line to $target_file"
}
