" Author: John Anderson (sontek@gmail.com)
" Modificacions: Antoni Aloy (aaloy@apsl.net)
" Modifications: Joan Miquel Torres (joanmiquel@mallorcaweb.net)
" Added: http://github.com/skyl/vim-config-python-ide/blob/supertab/.vimrc
" Added: http://code.google.com/p/pycopia/source/browse/trunk/vim/vimfiles/vimrc.vim
" Tested with vim7
"
" 5/04/2010 - Added tComment from http://www.vim.org/scripts/script.php?script_id=1173 "
"           - Added better tab completion (test shift+tab)
"           - Added markdown syntax
"           - Added additional colour themes
" 5/04/2010 - Merged with http://amix.dk/vim/vimrc.html
"
" Python:
let python_highlight_all=1

" Bad whitespace
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

:filetype plugin on
set iskeyword+=.

"" Skip this file unless we have +eval
if 1

""" Settings 
set nocompatible						" Don't be compatible with vi

"""" Movement
" work more logically with wrapped lines
noremap j gj
noremap k gk

"""" Searching and Patterns
set ignorecase							" search is case insensitive
set smartcase							" search case sensitive if caps on 
set incsearch							" show best match so far
set hlsearch							" Highlight matches to the search 


" tab labels show the filename without path(tail)
set guitablabel=%N/\ %t\ %M


"""" Editing
set backspace=2							" Backspace over anything! (Super backspace!)
set matchtime=2							" For .2 seconds
set formatoptions-=tc					" I can format for myself, thank you very much
set nosmartindent
set autoindent
set cindent
set tabstop=4							" Tab stop of 4
set shiftwidth=4						" sw 4 spaces (used on auto indent)
set softtabstop=4						" 4 spaces as a tab for bs/del
set matchpairs+=<:>						" specially for html
set showmatch							" Briefly jump to the previous matching parent

:endif



"" Tabulation:
"au BufRead,BufNewFile *.py  set ai sw=4 sts=4 et tw=72 " Doc strs
"au BufRead,BufNewFile *.js  set ai sw=2 sts=2 et tw=72 " Doc strs
"au BufRead,BufNewFile *.html set ai sw=2 sts=2 et tw=72 " Doc strs
"au BufRead,BufNewFile *.json set ai sw=4 sts=4 et tw=72 " Doc strs
"au BufNewFile *.html,*.py,*.pyw,*.c,*.h,*.json set fileformat=unix
"au! BufRead,BufNewFile *.json setfiletype json 


