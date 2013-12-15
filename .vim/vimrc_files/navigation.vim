
"Misc:"{{{
nmap gip gi<esc>pa
nmap ygip yiwgip
"}}}

" Tabs: {{{
map T :tabp<cr>
map t :tabn<cr>
"imap <c-T> <esc>:tabp<cr>
"imap <c-t> <esc>:tabn<cr>
" }}}

" Windows:"{{{
" (tmux-pane-like window shortcuts)
nmap <c-w>- <c-w><c-s>
nmap <c-w>\| <c-w><c-v>
nmap <c-w>! <c-w>o
noremap <c-w>K <c-w>-
noremap <c-w>J <c-w>+
"}}}

" Text blocks:{{{
map <c-j> /^\s*$<enter>
map <c-k> ?^\s*$<enter>
imap <c-j> <esc>/^\s*$<enter>a
imap <c-k> <esc>?^\s*$<enter>a
"}}}
