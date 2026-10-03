#!/usr/bin/env bash
# Superfile: pretty terminal file manager (https://superfile.dev)

CATEGORY="superfile"
DESCRIPTION="Superfile terminal file manager + JetBrainsMono Nerd Font"

# Ensure XDG_PUBLICSHARE_DIR is configured and exists. It holds spf-editor's
# "recent files" log (last_edited.md) plus symlinks to common config dirs.
ensure_publicshare_dir() {
    local pub
    pub="$(xdg-user-dir PUBLICSHARE 2>/dev/null || true)"

    # If unset, or "disabled" by pointing it at $HOME, configure a real dir.
    if [ -z "$pub" ] || [ "$pub" = "$HOME" ] || [ "$pub" = "$HOME/" ]; then
        pub="$HOME/Public"
        if command -v xdg-user-dirs-update &>/dev/null; then
            info "Configuring XDG_PUBLICSHARE_DIR -> $pub"
            xdg-user-dirs-update --set PUBLICSHARE "$pub" >/dev/null 2>&1 || true
        fi
    fi

    mkdir -p "$pub"
    ok "XDG_PUBLICSHARE_DIR -> $pub"
}

# Download and install the superfile binary (amd64/arm64).
install_superfile() {
    command -v curl &>/dev/null || { apt_install curl || true; }

    local version arch tarball url tmp
    version="$(curl -s --max-time 10 https://api.github.com/repos/yorukot/superfile/releases/latest 2>/dev/null \
        | grep '"tag_name"' | cut -d'"' -f4 | sed 's/^v//')"
    if [ -z "$version" ]; then
        warn "Could not determine latest superfile version — install manually"
        return 0
    fi

    case "$(uname -m)" in
        x86_64|amd64)  arch="amd64" ;;
        aarch64|arm64) arch="arm64" ;;
        *) warn "Unsupported architecture: $(uname -m) — install manually"; return 0 ;;
    esac

    tarball="superfile-linux-v${version}-${arch}.tar.gz"
    url="https://github.com/yorukot/superfile/releases/download/v${version}/${tarball}"

    info "Downloading superfile v${version} ($arch)..."
    tmp="/tmp/superfile-install-$$"
    mkdir -p "$tmp"
    if ! curl -sL -o "$tmp/$tarball" "$url"; then
        warn "Download failed: $url"
        rm -rf "$tmp"
        return 0
    fi
    tar -xzf "$tmp/$tarball" -C "$tmp" || { warn "Extract failed"; rm -rf "$tmp"; return 0; }

    local bin="$tmp/dist/superfile-linux-v${version}-${arch}/spf"
    if sudo -n true 2>/dev/null; then
        sudo mv "$bin" /usr/local/bin/spf && sudo chmod +x /usr/local/bin/spf
        ok "superfile v${version} installed to /usr/local/bin/spf"
    else
        info "No sudo available — installing to ~/.local/bin"
        mkdir -p "$HOME/.local/bin"
        mv "$bin" "$HOME/.local/bin/spf" && chmod +x "$HOME/.local/bin/spf"
        ok "superfile v${version} installed to ~/.local/bin/spf"
    fi
    rm -rf "$tmp"
}

# Install JetBrainsMono Nerd Font (superfile icons use Nerd Font glyphs).
install_nerd_font() {
    local font_dir="$HOME/.local/share/fonts/JetBrainsMonoNerd"
    if [ -d "$font_dir" ] && find "$font_dir" -name '*.ttf' -print -quit 2>/dev/null | grep -q .; then
        ok "JetBrainsMono Nerd Font already installed"
        return 0
    fi

    command -v curl &>/dev/null || { apt_install curl || true; }

    info "Installing JetBrainsMono Nerd Font..."
    local tmp="/tmp/jetbrainsmono-nerd-$$"
    mkdir -p "$font_dir" "$tmp"
    if curl -sL -o "$tmp/JetBrainsMono.tar.xz" \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"; then
        tar -xf "$tmp/JetBrainsMono.tar.xz" -C "$font_dir" || warn "Failed to extract Nerd Font"
        command -v fc-cache &>/dev/null && fc-cache -fv >/dev/null 2>&1 || true
        ok "JetBrainsMono Nerd Font installed"
    else
        warn "Nerd Font download failed — install manually if icons render as boxes"
    fi
    rm -rf "$tmp"
}

install() {
    ensure_publicshare_dir

    if command -v spf &>/dev/null; then
        info "superfile already installed: $(spf --version 2>/dev/null | head -1)"
    else
        install_superfile
    fi

    install_nerd_font
}

post_install() {
    stow_package superfile
}
