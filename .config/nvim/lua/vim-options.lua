
vim.cmd("set mouse=")
vim.cmd("set foldmethod=marker")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "

vim.cmd ("set matchpairs+=<:>")  -- specially for html

-- Searching and Patterns
vim.cmd ("set ignorecase")       -- search is case insensitive
vim.cmd ("set smartcase")        -- search case sensitive if caps on 
vim.cmd ("set incsearch")        -- show best match so far
vim.cmd ("set hlsearch")         -- Highlight matches to the search 


-- Movement
-- work more logically with wrapped lines
vim.cmd ("noremap j gj")
vim.cmd ("noremap k gk")

