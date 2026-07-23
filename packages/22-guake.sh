#!/usr/bin/env bash
# Guake terminal with OSC 52 support (from bitifet fork)

CATEGORY="guake"
DESCRIPTION="Guake terminal (forked with OSC 52 clipboard support)"

install() {
    if command -v guake &>/dev/null && guake --version 2>/dev/null | grep -q bitifet; then
        ok "Guake (bitifet fork) already installed"
        _GUAKE_ALREADY_INSTALLED=1
        return 0
    fi

    if ! confirm "Build and install Guake from bitifet fork?"; then
        return 0
    fi

    local build_dir="/tmp/guake-build-$$"

    info "Removing distro guake if present..."
    sudo apt-get remove -y guake 2>/dev/null || true

    info "Cloning guake fork..."
    git clone https://github.com/bitifet/guake.git "$build_dir"

    info "Installing build dependencies..."
    (cd "$build_dir" && ./scripts/bootstrap-dev-debian.sh)

    info "Building guake..."
    (cd "$build_dir" && make)

    info "Installing guake..."
    (cd "$build_dir" && sudo make install)

    info "Cleaning up build directory..."
    rm -rf "$build_dir"

    ok "Guake installed"

    echo "[APT] guake" >> "$DOTFILES/.install-log"
}

post_install() {
    if [ "${_GUAKE_ALREADY_INSTALLED:-0}" = "1" ]; then
        return 0
    fi
    if command -v guake &>/dev/null; then
        if confirm "Restart Guake now?"; then
            pkill guake 2>/dev/null || true
            sleep 0.5
            guake &
            ok "Guake restarted"
        else
            info "Run 'guake' to start, or add to startup apps."
        fi
    fi
}
