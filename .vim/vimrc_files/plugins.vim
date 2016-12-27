" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
call plug#begin('~/.vim/plugged')

" Markdown TOC generator:"{{{
" https://github.com/mzlogin/vim-markdown-toc
Plug 'mzlogin/vim-markdown-toc'
"}}}

