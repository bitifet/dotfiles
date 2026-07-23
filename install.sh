#!/usr/bin/env bash
# Bootstrap installer: clone dotfiles via HTTPS, then print next steps.
# Safe to curl | bash: curl -sSL https://raw.githubusercontent.com/bitifet/dotfiles/restructure/install.sh | bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
GIT_BRANCH="${GIT_BRANCH:-restructure}"
GIT_REPO="https://github.com/bitifet/dotfiles.git"
ALL_MODE=false

info()  { echo "  [INFO] $*"; }
warn()  { echo "  [WARN] $*" >&2; }
step()  { echo "==> $*"; }
ok()    { echo "  [OK] $*"; }

for arg in "$@"; do
    case "$arg" in
        -h|--help)
            echo "Usage: curl .../install.sh | bash"
            echo "   or: bash install.sh [--all]"
            echo ""
            echo "Environment variables:"
            echo "  DOTFILES_DIR   Target directory (default: ~/.dotfiles)"
            echo "  GIT_BRANCH     Branch to checkout (default: restructure)"
            exit 0
            ;;
        --all) ALL_MODE=true ;;
    esac
done

echo ""
echo "================================================================"
echo "  DotFiles Bootstrap"
echo "================================================================"
echo ""

# ---- Step 1: Ensure git ----
if ! command -v git &>/dev/null; then
    step "Installing git..."
    sudo apt-get update -qq && sudo apt-get install -y git
    ok "git installed"
else
    ok "git found: $(git --version)"
fi

# ---- Step 2: Clean up old home-as-git-root setup ----
if [ -d "$HOME/.git" ]; then
    step "Cleaning up old home-as-git-root setup..."

    if [ -d "$HOME/.etc" ]; then
        if git -C "$HOME" status --porcelain .etc/ 2>/dev/null | grep -q .; then
            warn "~/.etc has modifications. Keeping it (rename manually if needed)."
        else
            rm -rf "$HOME/.etc"
            ok "Removed ~/.etc"
        fi
    fi

    if [ -d "$HOME/bin" ]; then
        if git -C "$HOME" status --porcelain bin/ 2>/dev/null | grep -q .; then
            warn "~/bin has modifications. Keeping it (rename manually if needed)."
        else
            rm -rf "$HOME/bin"
            ok "Removed ~/bin"
        fi
    fi

    rm -rf "$HOME/.git"
    ok "Removed ~/.git"
fi

# ---- Step 3: Clone the repo ----
if [ -d "$DOTFILES_DIR/.git" ]; then
    ok "Dotfiles already cloned at $DOTFILES_DIR"
else
    step "Cloning dotfiles via HTTPS..."
    git clone -b "$GIT_BRANCH" "$GIT_REPO" "$DOTFILES_DIR"
    ok "Cloned to $DOTFILES_DIR"
fi

# ---- Step 4: Print next steps ----
echo ""
echo "================================================================"
echo "  Bootstrap complete!"
echo "================================================================"
echo ""
echo "Next steps:"
echo "  cd ~/.dotfiles"
echo "  ./setup.sh"
echo ""
echo "Options:"
echo "  ./setup.sh --all   Install everything non-interactively"
echo "  ./setup.sh --stow  Only create symlinks"
echo ""

if ! $ALL_MODE; then
    echo "Optional: switch the remote to SSH:"
    echo "  cd ~/.dotfiles"
    echo "  git remote set-url origin git@github.com:bitifet/dotfiles.git"
    echo ""
fi
