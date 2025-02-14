
vim.g.mapleader = " "

vim.cmd("set mouse=")
--vim.cmd("set foldmethod=marker")
vim.cmd("au BufEnter * set foldmethod=marker")
vim.cmd("au BufEnter *.otl set foldmethod=expr")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.cmd('set so=2') -- Minimum visible rows arround cursor.
vim.cmd('set wrap')
vim.cmd('set encoding=utf-8')
vim.cmd('set ffs=unix,dos,mac "Default file types')
vim.cmd('set showtabline=2') -- Remember which file is opened having multiple sessions.
vim.cmd('set rulerformat=%55(%F\\ \\ \\ \\ %=%c,%l/%L\\ \\ \\ \\ %P%)') -- Ruler with current file path
vim.cmd('set showbreak=\\|')

-- Clipboard copy & paste:
vim.cmd('vmap <leader><c-c> "+y')
vim.cmd('vmap <leader><c-x> "+d')
vim.cmd('nmap <leader><c-v> "+P')


-- [F11]: Invert list markers and paste mode: {{{
vim.cmd('noremap <F11> :set<space>invlist<enter>:set<space>invpaste<enter>')
vim.cmd('imap <F11> <esc><F11>a')
-- Not working???? inoremap <F11> <ESC>:set<space>invlist<enter>:set<space>invpaste<enter><a>
-- }}}


-- Syntax fixings:
vim.cmd('autocmd Syntax sql call set commentstring=--%s')


vim.cmd(':set colorcolumn=80')
vim.cmd(':hi ColorColumn ctermbg=darkgrey guibg=darkgrey ctermfg=white guifg=white')




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


-- Fielutils:
vim.cmd('command! Diff :w<space>!diff<space>-<space>%|less')
vim.cmd("command! Recovered :!<space>rm<space>$(echo<space>%<space>|perl<space>-pe<space>'s/^(.*\\/)?\\.?(.*)$/\\1.\\2.swp\\*/')")
vim.cmd('command! Path :!echo<space>%:p')

-- File name heading with ff:
vim.cmd ("nmap ff <esc>ggO<esc>cc// <c-r>%<esc>yypwv$r=0j")

-- <ESC><ESC> resets highithed text (after search):
vim.cmd ("nmap <esc><esc> :noh<enter>")


-- ┏━┓┏━╸┏┓╻╺┳┓╻┏┓╻┏━╸ 
-- ┣━┛┣╸ ┃┗┫ ┃┃┃┃┗┫┃╺┓╹
-- ╹  ┗━╸╹ ╹╺┻┛╹╹ ╹┗━┛╹
-- --------------------

-- " Vim outliner:
-- " =============
-- filetype plugin indent on

-- " Vimux:
-- " ======
-- :let VimuxUseNearest = 0


-- (colors)
-- " Visual:
-- hi Visual  ctermfg=Black ctermbg=gray


-- " [F9]: Redraw!"{{{
-- :map <f9> :redraw!<cr>
-- imap <f9> <esc><f9>a
-- "}}}



---=======



-- Formatting:
-- Json:
vim.cmd (":command! -range Json <line1>,<line2>:!python3<space>-m<space>json.tool")

-- Csv: (Convert selection to from SQL output to CSV)
--vim.cmd (":command! -range Csv <line1>,<line2>:s/^\s*/\"/|<line1>,<line2>:s/\s*|\s*/\";\"/g|<line1>,<line2>:s/\s*$/\"/|<line1>,<line2>:g/^\"[-+]*\"$/d")

-- F8 key -> Switch visually selected text between PUG and HTML:
vim.cmd (":vmap <F8> :!carlino<enter>")

-- F8 key -> Visually select all text (with no blank lines) under cursor and
-- switch between PUG and HTML:
vim.cmd (":nmap <F8> vip<F8>j")

-- Qjs: (Quote selection as javascript string)
--vim.cmd (":command! -range Qjs <line1>,<line2>:s/^/+ \"/|<line1>,<line2>:s/\s*$/\\n\"/g|<line1>:s/+\s//|:noh")

-- ,, Convert common '|' separated SQL output to comma-separted list."{{{
-- (suitable as other SQL input, like column names)
-- ------------------------------------------------------------------
--vim.cmd ("nmap ,, :s/\s*\|\s*/,<space>/g<enter>:noh<enter>
-- Same in visual mode, but multiline:
--vim.cmd ("vmap ,, :s/[<space>\n]*\|[<space>\n]*/,<space>/g<enter>:noh<enter>")

-- Same with only spaces:
--vim.cmd ("nmap ,,, :s/\(.\)\s\+\(.\)/\1,<space>\2/g<enter>:noh<enter>")
-- -------------------------------------------------------------------}}}

