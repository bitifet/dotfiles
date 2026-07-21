

"""" Buffer handling
set hidden           " Allow buffer switching without saving

"""" Searching and Patterns
set ignorecase       " search is case insensitive
set smartcase        " search case sensitive if caps on 
set incsearch        " show best match so far
set hlsearch         " Highlight matches to the search 


"""" Indentation 
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set autoindent
set listchars=tab:\|-
set list
set cindent

"""" Wrapping (when wrap is set)
set bri              " breakindent
set briopt=shift:2   " breakindent shift


"""" Testing on...
"set nosmartindent
set smartindent

set expandtab
au BufEnter * set expandtab
au BufEnter *.otl set noexpandtab


"" Skip this file unless we have +eval
if 1

"""" Movement
" work more logically with wrapped lines
noremap j gj
noremap k gk



" tab labels show the filename without path(tail)
set guitablabel=%N/\ %t\ %M


"""" Editing
set backspace=2        " Backspace over anything! (Super backspace!)
set matchtime=2        " For .2 seconds
set formatoptions-=tc  " I can format for myself, thank you very much
set matchpairs+=<:>    " specially for html
set showmatch          " Briefly jump to the previous matching parent


:endif

