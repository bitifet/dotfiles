#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
STOW_DIR="$DOTFILES/stow"

# ---- Logging ----
info()  { echo "  [INFO] $*"; }
warn()  { echo "  [WARN] $*" >&2; }
err()   { echo "  [ERROR] $*" >&2; }
step()  { echo -e "\033[1;36m==>\033[0m \033[1m$*\033[0m"; }
banner(){ echo -e "\n\033[1;36m================================\033[0m\n\033[1m$*\033[0m\n\033[1;36m================================\033[0m\n"; }
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
# $1 = title, $@ = alternating item/status pairs (item "ON"/"OFF")
select_categories() {
    local title="$1"; shift
    local items=("$@")

    if command -v whiptail &>/dev/null; then
        local args=()
        for ((i=0; i<${#items[@]}; i+=2)); do
            local label="${items[i]}"
            local desc=""
            [ "${items[i+1]}" = "OFF" ] && desc="[already installed]"
            args+=("$label" "$desc" "${items[i+1]}")
        done
        whiptail --title "$title" --checklist "Select what to install:" \
            20 70 "$(( ${#items[@]} / 2 ))" "${args[@]}" 3>&1 1>&2 2>&3
    elif command -v dialog &>/dev/null; then
        local args=()
        for ((i=0; i<${#items[@]}; i+=2)); do
            local label="${items[i]}"
            local desc=""
            [ "${items[i+1]}" = "OFF" ] && desc="[already installed]"
            args+=("$label" "$desc" "${items[i+1]}")
        done
        dialog --title "$title" --checklist "Select what to install:" \
            20 70 "$(( ${#items[@]} / 2 ))" "${args[@]}" 3>&1 1>&2 2>&3
    else
        echo "==> Available categories (already installed marked with ✅):"
        for ((i=0; i<${#items[@]}; i+=2)); do
            local mark=""
            [ "${items[i+1]}" = "OFF" ] && mark=" ✅"
            echo "    ${items[i]}$mark"
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

# Ensure add-apt-repository is available (installs software-properties-common)
ensure_add_apt_repository() {
    if ! command -v add-apt-repository &>/dev/null; then
        info "Installing software-properties-common (needed for add-apt-repository)..."
        sudo apt-get update -qq
        sudo apt-get install -y software-properties-common
    fi
}

# ---- Stow helpers ----
stow_package() {
    local pkg="$1"
    if [ ! -d "$STOW_DIR/$pkg" ]; then
        err "Stow package '$pkg' not found in $STOW_DIR"
        return 1
    fi

    # Collect targets that conflict (existing non-symlinks that would be overwritten)
    local conflicts=()
    while IFS= read -r file; do
        local target="$HOME/${file#$STOW_DIR/$pkg/}"
        if [ -e "$target" ] && [ ! -L "$target" ]; then
            # Skip if the resolved path is already inside the dotfiles repo
            local real_target
            real_target="$(readlink -f "$target" 2>/dev/null || echo "$target")"
            if [[ "$real_target" == "$DOTFILES"/* ]]; then
                continue
            fi
            conflicts+=("$target")
        fi
    done < <(find "$STOW_DIR/$pkg" -type f -not -path '*/.git/*')

    if [ ${#conflicts[@]} -gt 0 ]; then
        # Gather unique parent directories, shallowest first
        local dirs=()
        for f in "${conflicts[@]}"; do
            dirs+=("$(dirname "$f")")
        done
        local unique_dirs=()
        while IFS= read -r d; do
            [ -n "$d" ] && unique_dirs+=("$d")
        done < <(printf '%s\n' "${dirs[@]}" | sort -u)

        # Back up the shallowest directories that cover all conflicts
        local backed_up=()
        for d in "${unique_dirs[@]}"; do
            local covered=false
            for b in "${backed_up[@]}"; do
                if [[ "$d" == "$b"/* ]] || [ "$d" = "$b" ]; then
                    covered=true
                    break
                fi
            done
            $covered && continue

            if [ -d "$d" ] && [ ! -L "$d" ]; then
                warn "$d already exists, backing up to ${d}.bak"
                mv "$d" "${d}.bak"
                backed_up+=("$d")
            fi
        done

        # Handle any remaining files whose parent wasn't a backed-up dir
        for f in "${conflicts[@]}"; do
            if [ ! -e "$f" ]; then continue; fi
            local covered=false
            for b in "${backed_up[@]}"; do
                if [[ "$f" == "$b"/* ]]; then
                    covered=true; break
                fi
            done
            $covered && continue
            if [ -f "$f" ] && [ ! -L "$f" ]; then
                warn "$f already exists, backing up to ${f}.bak"
                mv "$f" "${f}.bak"
            fi
        done
    fi

    step "Stowing $pkg..."
    stow -v --no-folding -t "$HOME" -d "$STOW_DIR" "$pkg"
    echo "[STOW] $pkg" >> "$INSTALL_LOG"
}

unstow_package() {
    local pkg="$1"
    step "Unstowing $pkg..."
    stow -v --no-folding -D -t "$HOME" -d "$STOW_DIR" "$pkg" 2>/dev/null || true
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
    touch "$target_file"
    echo "" >> "$target_file"
    echo "# DotFiles Setup: $marker" >> "$target_file"
    echo "$source_line" >> "$target_file"
    ok "Added source line to $target_file"
}
