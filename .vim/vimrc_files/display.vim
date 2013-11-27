set so=2 " Minimum visible rows arround cursor.

" [F9]: Redraw!"{{{
:map <f9> :redraw!<cr>
imap <f9> <esc><f9>a
"}}}

" [F11]: Invert list markers and paste mode: {{{
noremap <F11> :set<space>invlist<enter>:set<space>invpaste<enter>
imap <F11> <esc><F11>a
" Not working???? inoremap <F11> <ESC>:set<space>invlist<enter>:set<space>invpaste<enter><a>
" }}}
