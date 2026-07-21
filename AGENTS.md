# AGENTS.md

## What this repo is

Personal dotfiles managed with **GNU stow**. No build system, no tests, no linter.

Structure:
```
stow/<package>/    — one dir per tool, mirrors $HOME (used by stow)
lib/               — shared shell helpers for install script
packages/          — one install script per software category
install.sh         — main setup script (interactive by default)
```

Configs live under `stow/<pkg>/` and get symlinked into `$HOME` via `stow -t ~ <pkg>`.

## Key conventions

- **Neovim** is the primary editor. Config at `stow/nvim/.config/nvim/init.lua` (lazy.nvim).
  Legacy `.vimrc` and `.vim/vimrc_files/` are **still sourced** by Neovim's init.lua —
  changes to those Vim files affect Neovim too.
- **Vim** is kept as a lightweight fallback (`stow/vim/`). Shares some config with Neovim
  via the vimrc_files directory.
- **Tmux** prefix is `Tab` (not `C-b`). Plugins managed by tpm (installed by setup script).
  Tmux plugins are NOT tracked in this repo — tpm installs them at runtime.
- `.ocmux.json` is **gitignored**. It's a runtime state file created/consumed by `bin/ocmux`.
  Never commit it.
- `stow/git/` exists but is empty — add `.gitconfig` there for per-machine git identity.

## Setup

    ./install.sh          # interactive: select what to install
    ./install.sh --all    # install everything non-interactively
    ./install.sh --stow   # only create symlinks

## ocmux

Manages opencode servers in a dedicated tmux session (`Opencode`).
The script is at `stow/tools/.local/bin/ocmux`. Commands:

    ocmux          # Switch to the opencode server found upward from $PWD
    ocmux new      # Start a new opencode server in $PWD
    ocmux kill     # Stop the server found upward from $PWD
    ocmux list     # List all running opencode servers

The script searches parent directories for `.ocmux.json` to find existing servers.
Each server runs `opencode serve --port 0` in a tmux window named after the project directory.

## Tmux

- Prefix is `Tab`. Press `Tab` twice to send literal Tab to apps.
- `F12` toggles to/from the Opencode tmux session.
- TERM set to `screen.xterm-256color` in tmux.conf.
- TPM plugins (resurrect) are installed by the setup script, not tracked in git.

## Editors

- Neovim is primary (`~/.config/nvim/` → stow/nvim). Plugin manager: lazy.nvim.
- Vim is fallback (`~/.vimrc` → stow/vim, `~/.vim/` → stow/vim). Plugin manager: vim-plug.
- Both share vimrc_files/ from `stow/vim/.vim/vimrc_files/`.
- Neovim sources these files directly: csv, mappings, formatting, netrw, emoji, ai.
- `ai.vim` provides `<Leader><CR>` to run AgentP on visual selection using ocmux URL.

## Shell config

- Bash config lives at `stow/bash/.config/bash/init.sh` (sourced from .bashrc via install script).
- `init.sh` sources `git_commands.sh` from the same dir and `git-prompt.sh` from `~/.local/bin/`.
- `git_commands.sh` provides: `git-worktree-exec`, `lswt`, `cdwt`, `rmwt`.
- PATH includes `~/.local/bin` (standard freedesktop location).

## Decisions made during restructure

- Switched from home-as-git-root to stow-based symlink management.
- Removed deprecated/unused: scl (screen manager), tml (tmux dialog launcher),
  nv (nvim-remote), sweat, drafts, svn.vim, 112.vim, oldStuff.vim, run.vim,
  unused/ directory, capslock, shift, old _setup.sh.
- Tmux plugins (tpm, resurrect) are no longer tracked — installed at setup time.
- TERM changed from `screen-256color` to `screen.xterm-256color`.
- Fixed hardcoded `/home/joanmi/` paths to use `$HOME` or relative paths.
- Migrated from `~/bin/` to `~/.local/bin/` (freedesktop standard).
