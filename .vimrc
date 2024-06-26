" ======================================
" .vimrc - My personal vim configuration
" ======================================
"
" Author: Joan Miquel Torres <joanmi@bitifet.net>
" Source: https://github.com/bitifet/homedir/blob/master/.vimrc
" Credits:
"    * "Vim recipes" (Bram Moolenar)
"    * Other contributions credits in its own script heading.
" Other credits:
"    (Syntax files & plugins included in my personal git home repo)
"    * Markdown: https://github.com/tpope/vim-markdown.git
"

"mapclear
autocmd!

set nocompatible
"set verbose=9

so ~/.vim/vimrc_files/editor.vim

so ~/.vim/vimrc_files/plugins.vim
so ~/.vim/vimrc_files/colors.vim
so ~/.vim/vimrc_files/addons.vim
so ~/.vim/vimrc_files/display.vim
so ~/.vim/vimrc_files/folding.vim
so ~/.vim/vimrc_files/navigation.vim
so ~/.vim/vimrc_files/filesystem.vim
so ~/.vim/vimrc_files/screen.vim
so ~/.vim/vimrc_files/csv.vim
so ~/.vim/vimrc_files/svn.vim
so ~/.vim/vimrc_files/git.vim
so ~/.vim/vimrc_files/mappings.vim
so ~/.vim/vimrc_files/formatting.vim
so ~/.vim/vimrc_files/run.vim
so ~/.vim/vimrc_files/netrw.vim
so ~/.vim/vimrc_files/misc.vim

so ~/.vim/vimrc_files/112.vim
so ~/.vim/vimrc_files/python.vim
so ~/.vim/vimrc_files/oldStuff.vim
so ~/.vim/vimrc_files/emoji.vim

so ~/.vim/vimrc_files/hilight.vim

" Update help files tags:
:helptags ~/.vim/doc

