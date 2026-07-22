# DotFiles

Personal configuration files and scripts, managed with **GNU stow**.

## Quick start

```bash
# Remote bootstrap (one-liner):
curl -sSL https://raw.githubusercontent.com/bitifet/dotfiles/restructure/install.sh | bash

# Or manual clone:
git clone -b restructure https://github.com/bitifet/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

The installer is interactive by default — select what to install per machine.

```bash
./setup.sh --all      # Install everything non-interactively
./setup.sh --stow     # Only create symlinks, skip software
./setup.sh --cleanup  # Revert stow symlinks and config changes
./cleanup.sh          # Revert stow + APT packages (interactive)
```

## What's included

| Package        | Contents                                    |
|----------------|---------------------------------------------|
| `bash`         | Shell init, aliases, git helpers, prompt    |
| `nvim`         | Neovim config (lazy.nvim, telescope, LSP)   |
| `vim`          | Lightweight Vim fallback (shares config)    |
| `tmux`         | Tmux config (prefix=Tab, tpm, resurrect)    |
| `tools`        | Utility scripts (ocmux, supergrep, f, ...)  |
| `less`         | less pager keybindings                      |
| `zellij`       | Zellij multiplexer config                   |
| `git`           | (empty — add per-machine .gitconfig)         |

## Structure

```
~/.dotfiles/
├── stow/          One dir per tool, mirrors $HOME for GNU stow
├── packages/      Install scripts per software category  
├── lib/           Shared shell helpers
├── install.sh     Main setup orchestrator
├── AGENTS.md      Instructions for AI agents working on this repo
└── README.md
```
