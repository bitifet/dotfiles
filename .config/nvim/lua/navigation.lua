

-- Text blocks skip:
vim.cmd("map <c-j> /^\\s*$<enter>:noh<enter>")
vim.cmd("map <c-k> ?^\\s*$<enter>:noh<enter>")
vim.cmd("imap <c-j> <esc>/^\\s*$<enter>:noh<enter>a")
vim.cmd("imap <c-k> <esc>?^\\s*$<enter>:noh<enter>a")
--

-- Text blocks move:
-- Credits: https://twitter.com/MasteringVim/status/811868588785143808?s=03
vim.cmd("vnoremap <c-j> :m '>+1<CR>gv=gv")
vim.cmd("vnoremap <c-k> :m '<-2<CR>gv=gv")
--

-- mm -> MM
-- mm (already, by default) creates "m" mark.
-- Now, define MM to go back to (handy) "m" mark:
vim.cmd("nmap MM 'm")
--


-- Scroll with <c-n> and <c-m>:
vim.cmd("nmap <c-n> <c-e>")
vim.cmd("nmap <c-m> <c-y>")


-- Paste after last edit position:
vim.cmd("nmap gip gi<esc>pa")
vim.cmd("nmap ygip yiwgip")


-- ===========
-- ñ-commands:
-- ===========
-- ñ: Buffer and tab management.

-- ------------------------
-- (ñ)
-- hjkl - hl (left - right)
-- Tab-Left - Tab-Right
-- Ctrl+... (Move)
-- ------------------------
vim.cmd("map ñh :tabp<enter>")
vim.cmd("map ñl :tabn<enter>")
vim.cmd("map ñ<c-h> :tabm<space>-1<enter>")
vim.cmd("map ñ<c-l> :tabm<space>+1<enter>")


-- ------------------------
-- (ñ)
-- hjkl - jk (down - up)
-- (Down) - Buffer management:
--   j: Switch buffer in Telescope.
--   J: Open new buffer (Netrw in current file directory)
--   (TODO) JJ: New unnamed buffer.
--   J%: (Hint) New nammed buffer (will be asked).
-- (Up) - New tab:
--   k: Netrw in current file directory.
--   K: Unnamed emtpy buffer.
-- ------------------------

-- Buffer management:
vim.cmd("nmap ñj :lua<space>require'telescope.builtin'.buffers()<cr><esc>")
vim.cmd("nmap ñJ :e<space>%:p:h<cr>")
vim.cmd("nmap ñJJ :lua<space>require'telescope.builtin'.find_files()<cr><esc>")
vim.cmd("nmap ñx :bd<cr>")
vim.cmd("nmap ñn :enew<cr>")
vim.cmd("nmap ñg :lua<space>require'telescope.builtin'.live_grep()<cr><esc>")

-- Tab management:
vim.cmd("nmap ñk :tabe<space>%:p:h<cr>")
vim.cmd("nmap ñK :tabe<cr>")

---- (vim.cmd("nmap ñj :Telescope buffers<cr>")
--vim.cmd("nmap ñJ :e<space>%:p:h<cr>")


-- ------------------------
--  Miscellaneous
-- ------------------------

-- ñu - Buffer change undo / switch.
vim.cmd("nmap ñu :buf<space>#<cr>")

-- gf in tabs:
vim.cmd("nmap ñgf :tabedit<space><cfile><CR>")

-- ñy "Cross-session" yank.
vim.cmd("noremap ñy :w!<space>~/.vim/clipboard.txt<enter>")

-- ñp "Cross-session" paste.
vim.cmd("noremap ñp :r<space>~/.vim/clipboard.txt<enter>")

-- ññ Cursor row+column+numbering switch.
-- ...also refresh Syntax hilighting
vim.cmd("nmap ññ :silent syntax sync fromstart<enter>:silent set<space>cursorline!<space>cursorcolumn!<space>number!<space>relativenumber!<enter>")

-- ñs Always show status bar.
vim.cmd("nmap ñs :silent set<space>laststatus=2<enter>")

-- ñs Only show status bar when more than one window exists.
vim.cmd("nmap ñS :silent set<space>laststatus=1<enter>")



-- ==============
-- <tab>-commands
-- ==============
-- <tab>: Window management.

-- --------------------------------
-- tmux-pane-like window shortcuts:
--  (Use double tab inside tmux)
-- --------------------------------

-- ------------------------
-- Split (horizntally / vertically):
-- Same file: '-' / '|' (tmux-like)
-- New buffer: '_' / '!'
-- Netrw in current file directory: '__' / '!!'
-- "Goto File" (gf): Ñgf / ÑgF
-- ------------------------
vim.cmd("set splitbelow")
vim.cmd("nmap <tab>- <c-w><c-s>")
vim.cmd("nmap <tab>_ :new<enter>")
vim.cmd("nmap <tab>__ <tab>_ñJ")
vim.cmd("nmap <tab>gf :new<space><cfile><CR>")
vim.cmd("set splitright")
vim.cmd("nmap <tab>\\| <c-w><c-v>")
vim.cmd("nmap <tab>! :vnew<enter>")
vim.cmd("nmap <tab>!! <tab>!ñJ")
vim.cmd("nmap <tab>gF :vnew<space><cfile><CR>")

-- Close (current / all other) windows:
vim.cmd("nmap <tab>x <c-w>c")
vim.cmd("nmap <tab>X <c-w>o")

-- Window navigation (hjkl)
vim.cmd("nmap <tab>h <c-w>h")
vim.cmd("nmap <tab>j <c-w>j")
vim.cmd("nmap <tab>k <c-w>k")
vim.cmd("nmap <tab>l <c-w>l")

-- Window resizing (hjkl)
vim.cmd("nmap <tab>H :vertical<space>resize<space>-1<enter>")
vim.cmd("nmap <tab>J :resize<space>+1<enter>")
vim.cmd("nmap <tab>K :resize<space>-1<enter>")
vim.cmd("nmap <tab>L :vertical<space>resize<space>+1<enter>")
-- HINT: Tmux config to make resizing repeatable:
-- -----------------------------------------------
-- # Resize:
-- # (Repeatable) Resize with Meta-hjkl:
-- bind -r M-h send-keys <tab>H
-- bind -r M-j send-keys <tab>J
-- bind -r M-k send-keys <tab>K
-- bind -r M-l send-keys <tab>L
-- -----------------------------------------------



