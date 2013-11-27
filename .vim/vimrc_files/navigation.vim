
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

" Splits:"{{{
nmap <c-l> <c-w>k
nmap <c-h> <c-w>j
"}}}

" Text blocks:{{{
map <c-j> /^\s*$<enter>
map <c-k> ?^\s*$<enter>
imap <c-j> <esc>/^\s*$<enter>a
imap <c-k> <esc>?^\s*$<enter>a
"}}}
