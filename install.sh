#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
export DOTFILES

# Source shared library
source "$DOTFILES/lib/setup-lib.sh"

# ---- Option parsing ----
ALL_MODE=false
STOW_ONLY=false
ARG_CATEGORIES=()

for arg in "$@"; do
    case "$arg" in
        -h|--help)
            echo "Usage: install.sh [--all] [--stow] [--packages <name> ...]"
            echo ""
            echo "Options:"
            echo "  --all        Install everything non-interactively"
            echo "  --stow       Only create/manage symlinks"
            echo "  --packages   Install specific package scripts (e.g. 30-editors.sh)"
            exit 0
            ;;
        --all)  ALL_MODE=true ;;
        --stow) STOW_ONLY=true ;;
        --packages) shift; ARG_CATEGORIES+=("$@"); break ;;
        *)      ARG_CATEGORIES+=("$arg") ;;
    esac
done

# ---- Discover available packages ----
PACKAGE_DIR="$DOTFILES/packages"
AVAILABLE=()
DECLARED_ORDER=()

if [ -d "$PACKAGE_DIR" ]; then
    for script in "$PACKAGE_DIR"/*.sh; do
        [ -f "$script" ] || continue
        source "$script"
        if [ -n "${CATEGORY:-}" ]; then
            AVAILABLE+=("$CATEGORY")
            DECLARED_ORDER+=("$CATEGORY:$script")
        fi
    done
fi

if [ ${#AVAILABLE[@]} -eq 0 ]; then
    err "No package scripts found in $PACKAGE_DIR"
    exit 1
fi

# ---- Phase 1: Symlinks ----
if ! $STOW_ONLY; then
    step "Checking dependencies..."
    if ! command -v stow &>/dev/null; then
        err "GNU stow is required. Install with: sudo apt install stow"
        exit 1
    fi
    ok "stow found"
fi

step "Creating symlinks..."

# Always stow these core packages:
stow_package bash
stow_package tools

# The rest are stowed by their respective post_install hooks
# (so we don't create dangling symlinks for uninstalled tools)

# Set up VI mode in bash if .bashrc doesn't already source us
inject_source_line "$HOME/.bashrc" \
    "source ~/.config/bash/init.sh" \
    "DotFiles"

ok "Symlinks created"

if $STOW_ONLY; then
    echo ""
    echo "Symlink phase complete. Run 'install.sh' to install software."
    exit 0
fi

# ---- Phase 2: Select categories ----
SELECTED=()

if $ALL_MODE; then
    SELECTED=("${AVAILABLE[@]}")
elif [ ${#ARG_CATEGORIES[@]} -gt 0 ]; then
    SELECTED=("${ARG_CATEGORIES[@]}")
else
    step "Select software categories to install"
    echo ""
    SELECTED_STR=$(select_categories "Software Setup" "${AVAILABLE[@]}")
    # Parse whiptail/dialog output (quoted strings) or text input
    SELECTED_STR="${SELECTED_STR//\"/}"
    IFS=' ' read -ra SELECTED <<< "$SELECTED_STR"
fi

if [ ${#SELECTED[@]} -eq 0 ]; then
    warn "No categories selected. Skipping software installation."
    exit 0
fi

echo ""
step "Will install: ${SELECTED[*]}"
confirm "Proceed?" || exit 0
echo ""

# ---- Phase 3: Install selected packages ----
for category in "${SELECTED[@]}"; do
    script=""
    for entry in "${DECLARED_ORDER[@]}"; do
        if [ "${entry%%:*}" = "$category" ]; then
            script="${entry#*:}"
            break
        fi
    done

    if [ -z "$script" ] || [ ! -f "$script" ]; then
        warn "Package script for '$category' not found, skipping"
        continue
    fi

    # Source again to get fresh functions (in case variables changed)
    CATEGORY=""; DESCRIPTION=""
    source "$script"

    echo ""
    echo "================================================================"
    echo "  Installing: $category"
    echo "  $DESCRIPTION"
    echo "================================================================"
    echo ""

    install
    post_install
done

# ---- Phase 4: Post-install ----
echo ""
echo "================================================================"
echo "  Setup complete!"
echo "================================================================"
echo ""
echo "Next steps:"
echo "  - Restart your shell or run: source ~/.bashrc"
echo "  - Launch tmux and press prefix + I to install tmux plugins"
echo "  - Run ':Lazy sync' in neovim if plugins didn't install"
echo "  - Set up git identity: git config --global user.name/email"
echo ""
