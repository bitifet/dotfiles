set so=2 " Minimum visible rows arround cursor.
set wrap
set encoding=utf-8
set ffs=unix,dos,mac "Default file types
set showtabline=2 "Remember which file is opened having multiple sessions.
set rulerformat=%55(%F\ \ \ \ %=%c,%l/%L\ \ \ \ %P%) "Ruler with current file path
set showbreak=\|






" [F9]: Redraw!"{{{
:map <f9> :redraw!<cr>
imap <f9> <esc><f9>a
"}}}

" [F11]: Invert list markers and paste mode: {{{
noremap <F11> :set<space>invlist<enter>:set<space>invpaste<enter>
imap <F11> <esc><F11>a
" Not working???? inoremap <F11> <ESC>:set<space>invlist<enter>:set<space>invpaste<enter><a>
" }}}

