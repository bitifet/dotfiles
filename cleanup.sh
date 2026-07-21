#!/usr/bin/env bash
# cleanup.sh - Revert changes made by install.sh
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
export DOTFILES
source "$DOTFILES/lib/setup-lib.sh"

INSTALL_LOG="$DOTFILES/.install-log"
FORCE=false

for arg in "$@"; do
    case "$arg" in
        -h|--help)
            echo "Usage: cleanup.sh [--force]"
            echo ""
            echo "  --force   Skip confirmation prompts"
            exit 0
            ;;
        --force) FORCE=true ;;
    esac
done

echo "================================================================"
echo "  DotFiles Cleanup"
echo "================================================================"
echo ""

if ! $FORCE; then
    confirm "This will remove symlinks and undo config changes. Continue?" "n" || exit 0
fi

# ---- Phase 1: Unstow all packages ----
step "Removing stow symlinks..."

if [ -d "$STOW_DIR" ]; then
    for pkg_dir in "$STOW_DIR"/*/; do
        pkg=$(basename "$pkg_dir")
        if stow -t "$HOME" -d "$STOW_DIR" 2>/dev/null -D "$pkg" 2>/dev/null; then
            ok "Unstowed: $pkg"
        fi
    done
fi

# ---- Phase 2: Remove .bashrc injection ----
step "Cleaning .bashrc..."

if [ -f "$HOME/.bashrc" ]; then
    sed -i '/# DotFiles Setup:/,/source ~\/.config\/bash\/init.sh/d' "$HOME/.bashrc"
    ok "Removed DotFiles source from .bashrc"
fi

# ---- Phase 3: Remove autostart files ----
step "Cleaning autostart..."

if [ -f "$HOME/.config/autostart/capslock-remap.desktop" ]; then
    rm -f "$HOME/.config/autostart/capslock-remap.desktop"
    ok "Removed CapsLock autostart entry"
fi

# ---- Phase 4: Show what's left from install log ----
if [ -f "$INSTALL_LOG" ]; then
    echo ""
    step "Previous installations (from .install-log):"
    grep -E '^\[APT\]|^\[STOW\]|^\[SNAP\]' "$INSTALL_LOG" 2>/dev/null || true
    echo ""
    if confirm "Uninstall APT packages listed above?" "n"; then
        grep '^\[APT\]' "$INSTALL_LOG" 2>/dev/null | sed 's/\[APT\] //' | xargs -r sudo apt-get remove -y 2>/dev/null || true
        ok "APT packages removed"
    fi
    rm -f "$INSTALL_LOG"
    ok "Removed install log"
fi

echo ""
step "Cleanup complete."
echo ""
echo "Note: manually-installed software (nvm, npm globals, Brave,"
echo "  Tailscale) and system configs are not fully removed."
echo "  Remove these separately if needed."
