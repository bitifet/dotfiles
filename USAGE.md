# Usage Guide

## How it works

This repository lives at `~/.dotfiles`. GNU **stow** creates symlinks from your
`$HOME` into `stow/<package>/`. Each package directory mirrors `$HOME`:

```
~/.dotfiles/stow/bash/.config/bash/init.sh   →  ~/.config/bash/init.sh
~/.dotfiles/stow/nvim/.config/nvim/          →  ~/.config/nvim/init.lua etc.
~/.dotfiles/stow/tools/.local/bin/f          →  ~/.local/bin/f
```

**You edit files in `~/.dotfiles/`** and the changes take effect immediately in
`$HOME` because they are symlinked. **You commit inside `~/.dotfiles/`** to
version-control everything.

## Customizing your shell

The bash entry point is `~/.config/bash/init.sh` (symlinked from
`stow/bash/.config/bash/init.sh`).

- **Aliases**: add them directly to `init.sh`.
- **Environment variables**: add `export` lines to `init.sh`.
- **Git helpers**: live in `stow/bash/.config/bash/git_commands.sh`.
- **Git prompt**: lives in `stow/tools/.local/bin/git-prompt.sh`.

After editing, either restart your terminal or `source ~/.bashrc`.

> `~/.bashrc` contains only one custom line added by `setup.sh`:
> `source ~/.config/bash/init.sh`. If you already have a `.bashrc`, it was
> backed up as `.bashrc.bak`.

## Customizing Neovim

Your Neovim config lives at `~/.config/nvim/` (symlinked from
`stow/nvim/.config/nvim/`). It uses [`lazy.nvim`](https://github.com/folke/lazy.nvim).

| File | Purpose |
|---|---|
| `init.lua` | Entry point |
| `lua/vim-options.lua` | General settings, mappings, keybinds |
| `lua/navigation.lua` | File/buffer/tab navigation (telescope, netrw) |
| `lua/plugins/*.lua` | Plugin specs (one file per plugin or group) |
| `lazy-lock.json` | Pinned plugin versions (commit this file) |

To add a plugin, create a new file in `lua/plugins/`. Example
(`lua/plugins/my-plugin.lua`):

```lua
return {
    {
        "author/my-plugin",
        config = function()
            require("my-plugin").setup({ option = true })
        end,
    },
}
```

Then run `:Lazy sync` in Neovim to install it.

To add a keybinding, edit `lua/vim-options.lua` or `lua/navigation.lua`.

## Customizing Vim (legacy)

Vim config lives at `~/.vimrc` and `~/.vim/` (symlinked from `stow/vim/`).
Plugins are managed by `vim-plug` (`stow/vim/.vim/vimrc_files/plugins.vim`).

Some vimrc files are **shared** with Neovim (sourced from `init.lua`):
`csv.vim`, `mappings.vim`, `formatting.vim`, `netrw.vim`, `emoji.vim`,
`ai.vim`. Editing these affects both editors.

## Adding your own scripts

Put scripts in `stow/tools/.local/bin/`. Make them executable (`chmod +x`).
They become available at `~/.local/bin/<name>` immediately.

```bash
cd ~/.dotfiles
vim stow/tools/.local/bin/my-script
chmod +x stow/tools/.local/bin/my-script
git add stow/tools/.local/bin/my-script
git commit -m "Add my-script"
```

## Managing git identity

`stow/git/` is an empty directory ready for your `.gitconfig`. Create it
per-machine (it is not tracked so each machine can have its own identity):

```bash
cp ~/.gitconfig ~/.dotfiles/stow/git/.gitconfig   # copy existing
# or create fresh:
git config -f ~/.dotfiles/stow/git/.gitconfig user.name "Your Name"
git config -f ~/.dotfiles/stow/git/.gitconfig user.email "you@example.com"
```

Then tell `setup.sh` to stow it:

```bash
cd ~/.dotfiles && ./setup.sh --stow
```

(or manually: `stow -t ~ -d ~/.dotfiles/stow git`)

The file is gitignored by default — remove `.gitconfig` from `.gitignore` if
you want to version-control a shared identity.

## Adding a new stow package (new config type)

Say you want to manage `~/.config/htop/htoprc`:

```bash
cd ~/.dotfiles
mkdir -p stow/htop/.config/htop
cp ~/.config/htop/htoprc stow/htop/.config/htop/htoprc
stow -t ~ -d stow htop     # creates the symlink
git add stow/htop
git commit -m "Add htop config"
```

## Rerunning setup on an existing machine

```bash
cd ~/.dotfiles
git pull
./setup.sh     # already-installed categories are pre-unchecked
```

## Cleanup and recovery

| Command | What it does |
|---|---|
| `./setup.sh --cleanup` | Remove stow symlinks, undo bashrc changes |
| `./cleanup.sh` | Same, plus optionally remove installed APT packages |
| `rm -rf ~/.config/nvim.bak ~/.bashrc.bak` | Remove old backed-up configs |

If something goes wrong and you have `.bak` files all over, run `setup.sh` —
it will detect them and offer removal.

To start completely fresh:

```bash
cd ~/.dotfiles
./setup.sh --cleanup
./cleanup.sh
# Remove ~/.dotfiles and re-clone if needed
```

## Creating a new setup script for additional software

See `packages/` for examples. A minimal script:

```bash
#!/usr/bin/env bash
CATEGORY="myapp"
DESCRIPTION="My custom application"

install() {
    apt_install myapp
}

post_install() {
    stow_package myapp
}
```

Drop it in `packages/` and it appears in the interactive menu automatically.

## .ocmux.json

This is a runtime state file created by `ocmux` (part of `agentp` npm package).
It is **gitignored** — never commit it. Delete it to reset the opencode server
for a project directory.
