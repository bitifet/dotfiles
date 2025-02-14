
-- --------------------------- --
-- Local functions definitions --
-- --------------------------- --

-- Define a local function for reuse
local function find_files_from_current_dir()
    local bufname = vim.api.nvim_buf_get_name(0)  -- Get buffer name
    local filetype = vim.bo.filetype  -- Get current buffer's filetype
    local dir

    if filetype == "netrw" or bufname == "" then
        dir = vim.fn.getcwd()  -- Use working directory for Netrw or unnamed buffers
    else
        dir = vim.fn.fnamemodify(bufname, ":h")  -- Extract directory from file path
    end

    require("telescope.builtin").find_files({ search_dirs = { dir } })
    
    vim.schedule(function()
        vim.api.nvim_input("<Esc>")
    end)
end

-- ---------------------------- --
-- /Local functions definitions --
-- ---------------------------- --


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

-- Tab management:
-- ------------------------
-- (ñ)
-- hjkl - hl (left - right)
-- Tab-Left - Tab-Right
-- Ctrl+... (Move)
-- ------------------------
vim.cmd("map ñh :tabp<enter>")
    -- Select previous (left) tab
vim.cmd("map ñl :tabn<enter>")
    -- Select next (right) tab
vim.cmd("map ñ<c-h> :tabm<space>-1<enter>")
    -- Move current tab to the left
vim.cmd("map ñ<c-l> :tabm<space>+1<enter>")
    -- Move current tab to the right


-- ------------------------
-- (ñ)
-- hjkl - jk (down - up)
-- (Down) - Buffer management:
--   j: Switch buffer in Telescope.
--   ...
-- (Up) - New tab:
--   k: Netrw in current file directory.
--   K: Unnamed emtpy buffer.
-- ------------------------

vim.cmd("nmap ñj :lua<space>require'telescope.builtin'.buffers()<cr><esc>")
    -- Buffer switching.
vim.cmd("nmap ñjj :e<space>%:p:h<cr>")
    -- Netrw file manager
vim.keymap.set("n", "ñjjj", find_files_from_current_dir, { noremap = true, silent = true })
    -- Telescope file finder
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "netrw",
--     callback = function()
--         vim.defer_fn(function()
--             vim.keymap.set("n", "ñjjj", "cd", { noremap = true, silent = true, buffer = true })
--         end, 100) -- Delay by 100ms
--     end
-- })
    -- Telescope finder in netrw buffers (pick selected directory)
    -- 🚧  Does not yet work!!

vim.cmd("nmap ñg :lua<space>require'telescope.builtin'.live_grep()<cr>")
    -- Telescope grep finder

vim.cmd("nmap ñx :bd<cr>")
    -- Close buffer
vim.cmd("nmap ñn :enew<cr>")
    -- Create new unnamed buffer

vim.cmd("nmap ñk :tabe<space>%:p:h<cr>")
    -- New tab (Netrw file manager)
vim.cmd("nmap ñK :tabe<cr>")
    -- New tab (New unnamed buffer)

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



