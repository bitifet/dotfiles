#!/usr/bin/env bash
# Editors: neovim and vim

CATEGORY="editors"
DESCRIPTION="Neovim and Vim"

install() {
    # Neovim (prefer newer versions from official PPA or direct download)
    if command -v nvim &>/dev/null; then
        ok "Neovim already installed"
    elif apt-cache show neovim &>/dev/null 2>&1; then
        apt_install neovim
    else
        info "Installing Neovim via snap..."
        sudo snap install nvim --classic 2>/dev/null || {
            info "Installing Neovim appimage..."
            curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
            chmod +x nvim-linux-x86_64.appimage
            sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
        }
    fi

    apt_install vim python3-pip 2>/dev/null || true
}

post_install() {
    # Stow neovim package
    stow_package nvim

    # Stow vim package (legacy)
    stow_package vim

    # Install vim-plug for legacy vim
    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
        curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # Install lazy.nvim (neovim plugin manager)
    if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
        info "Installing lazy.nvim..."
        git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
            "$HOME/.local/share/nvim/lazy/lazy.nvim"
        ok "lazy.nvim installed"
    fi

    # Install neovim plugins (headless)
    if command -v nvim &>/dev/null; then
        info "Installing neovim plugins..."
        nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
        info "Updating helptags..."
        nvim --headless "+helptags ~/.vim/doc" "+helptags ALL" +qa 2>/dev/null || true
    fi
}
