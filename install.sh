#!/usr/bin/env bash
# Bootstrap installer: clones dotfiles and runs setup.sh
# Safe to curl | bash: curl -sSL https://raw.githubusercontent.com/bitifet/dotfiles/restructure/install.sh | bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
GIT_BRANCH="${GIT_BRANCH:-restructure}"
GIT_REPO="${GIT_REPO:-git@github.com:bitifet/dotfiles.git}"
GIT_REPO_HTTPS="https://github.com/bitifet/dotfiles.git"
ALL_MODE=false

info()  { echo "  [INFO] $*"; }
warn()  { echo "  [WARN] $*" >&2; }
err()   { echo "  [ERROR] $*" >&2; }
step()  { echo "==> $*"; }
ok()    { echo "  [OK] $*"; }

confirm() {
    local prompt="${1:-Continue?}"
    local default="${2:-y}"
    if [ -t 0 ]; then
        if [ "$default" = "y" ]; then
            read -r -p "$prompt [Y/n] " reply
            [ "${reply,,}" != "n" ]
        else
            read -r -p "$prompt [y/N] " reply
            [ "${reply,,}" = "y" ]
        fi
    else
        [ "$default" = "y" ]
    fi
}

for arg in "$@"; do
    case "$arg" in
        -h|--help)
            echo "Usage: curl .../install.sh | bash"
            echo "   or: bash install.sh [--all]"
            echo ""
            echo "Environment variables:"
            echo "  DOTFILES_DIR   Target directory (default: ~/.dotfiles)"
            echo "  GIT_BRANCH     Branch to checkout (default: restructure)"
            echo "  GIT_REPO       Git remote (default: git@github.com:bitifet/dotfiles.git)"
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

# ---- Step 2: Detect old home-as-git-root setup ----
if [ -d "$HOME/.git" ]; then
    step "Detected old setup (home directory under git)"
    warn "Your home directory is currently a git repository."
    echo ""
    echo "  Directories to clean: ~/.etc ~/bin ~/.git"
    echo ""

    if [ -t 0 ]; then
        if ! confirm "Clean up old setup and migrate to stow-based dotfiles?" "n"; then
            err "Aborted. Remove ~/.git manually before retrying."
            exit 1
        fi
    else
        warn "Non-interactive mode: skipping old setup cleanup."
        warn "If you want to clean up, run this script in a terminal."
    fi

    # Check for local modifications before removing
    if [ -d "$HOME/.etc" ]; then
        local changes
        changes=$(git -C "$HOME" status --porcelain .etc/ 2>/dev/null || true)
        if [ -n "$changes" ]; then
            warn "~/.etc has uncommitted changes:"
            echo "$changes"
            confirm "Remove ~/.etc anyway?" "n" || { err "Aborted."; exit 1; }
        fi
        rm -rf "$HOME/.etc"
        ok "Removed ~/.etc"
    fi

    if [ -d "$HOME/bin" ]; then
        local changes
        changes=$(git -C "$HOME" status --porcelain bin/ 2>/dev/null || true)
        if [ -n "$changes" ]; then
            warn "~/bin has uncommitted changes:"
            echo "$changes"
            confirm "Remove ~/bin anyway?" "n" || { err "Aborted."; exit 1; }
        fi
        rm -rf "$HOME/bin"
        ok "Removed ~/bin"
    fi

    rm -rf "$HOME/.git"
    ok "Removed ~/.git"
fi

# ---- Step 3: Clone the repo ----
if [ -d "$DOTFILES_DIR/.git" ]; then
    ok "Dotfiles already cloned at $DOTFILES_DIR"
else
    step "Cloning dotfiles..."

    local clone_url="$GIT_REPO"

    # If no SSH keys and not explicitly overridden, use HTTPS
    if [ "${GIT_REPO:-}" = "git@github.com:bitifet/dotfiles.git" ]; then
        if ! ssh -o BatchMode=yes -o ConnectTimeout=3 git@github.com 2>&1 | grep -q 'successfully authenticated'; then
            if confirm "SSH to GitHub failed. Use HTTPS instead?"; then
                clone_url="$GIT_REPO_HTTPS"
            fi
        fi
    fi

    git clone -b "$GIT_BRANCH" "$clone_url" "$DOTFILES_DIR"
    ok "Cloned to $DOTFILES_DIR"
fi

# ---- Step 4: Run setup.sh ----
step "Running setup..."
cd "$DOTFILES_DIR"

SETUP_ARGS=""
$ALL_MODE && SETUP_ARGS="--all"

exec ./setup.sh $SETUP_ARGS
