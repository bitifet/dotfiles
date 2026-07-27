#!/usr/bin/env bash
# Editors: neovim (latest) and vim with dependencies

CATEGORY="editors"
DESCRIPTION="Neovim (latest) + Vim + editor dependencies"

install() {
    # Neovim dependencies
    apt_install ripgrep fd-find python3-pip python3-venv unzip curl gcc g++ make tar

    # Tree-sitter CLI (needed by nvim-treesitter)
    if ! command -v tree-sitter &>/dev/null; then
        info "Installing tree-sitter-cli..."
        if command -v cargo &>/dev/null; then
            cargo install tree-sitter-cli 2>/dev/null || \
                info "tree-sitter-cli: install manually if nvim-treesitter build fails"
        elif command -v npm &>/dev/null; then
            npm install -g tree-sitter-cli 2>/dev/null || \
                info "tree-sitter-cli: install manually if nvim-treesitter build fails"
        else
            info "tree-sitter-cli: install manually (cargo install tree-sitter-cli or npm i -g tree-sitter-cli)"
            info "Needed for nvim-treesitter parser compilation."
        fi
    fi

    # Install latest neovim
    if command -v nvim &>/dev/null; then
        info "Neovim already installed: $(nvim --version | head -1)"
    else
        local installed=false

        # Try 1: distro package if recent enough
        if apt-cache show neovim &>/dev/null 2>&1; then
            local nvim_ver
            nvim_ver=$(apt-cache show neovim 2>/dev/null | grep -m1 '^Version:' | cut -d' ' -f2 | head -c2)
            if [ "${nvim_ver:-0}" -ge 10 ] 2>/dev/null; then
                apt_install neovim
                installed=true
            fi
        fi

        # Try 2: PPA if add-apt-repository is available
        if ! $installed && ensure_add_apt_repository; then
            info "Adding neovim PPA..."
            sudo add-apt-repository -y ppa:neovim-ppa/unstable && {
                sudo apt-get update -qq
                apt_install neovim
                installed=true
            }
        fi

        # Try 3: AppImage fallback
        if ! $installed; then
            warn "Could not install neovim via apt/PPA."
            if confirm "Download neovim AppImage instead?"; then
                local nvim_url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"
                info "Downloading neovim AppImage..."
                sudo curl -L -o /usr/local/bin/nvim "$nvim_url"
                sudo chmod +x /usr/local/bin/nvim
                ok "Neovim AppImage installed to /usr/local/bin/nvim"
            else
                info "Skipping neovim. Install manually later."
            fi
        fi
    fi

    apt_install vim 2>/dev/null || true

    # fd-find might be called fdfind on some distros
    if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
        ensure_dir "$HOME/.local/bin"
        ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
    fi
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
        # Force-reinstall treesitter if its config module is missing
        info "Verifying nvim-treesitter..."
        if nvim --headless -c "lua local ok = pcall(require, 'nvim-treesitter.configs') if ok then vim.cmd('qall!') else vim.cmd('cq') end" 2>/dev/null; then
            ok "nvim-treesitter configs module found"
            # Remove old parsers: AppImage neovim may need recompilation
            local parser_dir="$HOME/.local/share/nvim/site/parser"
            if [ -d "$parser_dir" ]; then
                info "Cleaning old treesitter parsers for fresh rebuild..."
                rm -rf "$parser_dir"
            fi
            info "Installing treesitter parsers..."
            nvim --headless "+TSInstallSync all" +qa 2>/dev/null || true
        else
            warn "nvim-treesitter needs reinstall. Run in nvim: :Lazy sync nvim-treesitter"
            warn "Then run: :TSUpdate"
        fi
    fi

    # Install vim plugins
    if command -v vim &>/dev/null; then
        info "Installing vim plugins..."
        vim "+PlugInstall" "+qa" 2>/dev/null || true
    fi
}
