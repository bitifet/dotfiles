
"Misc:"{{{
nmap gip gi<esc>pa
nmap ygip yiwgip
"}}}

" Tabs: {{{
map <c-h> :tabp<enter>
map <c-l> :tabn<enter>
imap <c-h> <esc>:tabp<enter>
imap <c-l> <esc>:tabn<enter>
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
