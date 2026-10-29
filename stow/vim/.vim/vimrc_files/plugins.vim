" Load vim-plug
" -------------
" https://vi.stackexchange.com/questions/388/what-is-the-difference-between-the-vim-plugin-managers?answertab=active#tab-top
" -------------
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
let g:tmux_navigator_no_mappings = 1
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

" Matchit (%)
Plug 'https://github.com/adelarsq/vim-matchit'

" OSC 52 clipboard via escape sequences (works over SSH + tmux):
Plug 'ojroques/vim-oscyank'

" Seamless navigation between Vim splits and tmux panes (custom Tab+hjkl maps)
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
