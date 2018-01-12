" Load vim-plug
" -------------
" https://vi.stackexchange.com/questions/388/what-is-the-difference-between-the-vim-plugin-managers?answertab=active#tab-top
" -------------
" if empty(glob("~/.vim/autoload/plug.vim"))
"     execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
" endif
" ------------------------------------------------------------------

" NOTE:
" =====
"
" Use ':PlugInstall' to install new plugins.
" Use ':PlugClean' to remove old (not yet declared) plugins.
"


call plug#begin()


" Markdown TOC generator:
" https://github.com/mzlogin/vim-markdown-toc
Plug 'mzlogin/vim-markdown-toc'

" Markdown / https://github.com/SidOfc/mkdx
Plug 'SidOfc/mkdx'

call plug#end()
