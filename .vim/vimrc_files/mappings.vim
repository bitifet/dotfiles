
"Miscellaneous mappings:
""""""""""""""""""""""""

" File name heading with ff:
nmap ff <esc>ggO<esc>cc// <c-r>%<esc>yypwv$r=0j

" <ESC><ESC> resets highithed text (after search):
nmap <esc><esc> :noh<enter>



" Insert mode mappings:
" """""""""""""""""""""

" (()) Expands timestamp like (sat20101218-1217)
imap (()) (<enter><enter><esc>kV:!date<space>+\%a\%G\%m\%d-\%H\%M<enter>kJJi)<esc>F(lxf)lxa
imap (())<BS> (<enter><enter><esc>kV:!date<space>+\%a\%G\%m\%d<enter>kJJi)<esc>F(lxf)lxa



" Old stuff:"{{{
" """"""""""

"<enter><del> mappings for quoted strings: {{{
"(unused)"map <enter><del> a\n"<enter>. "<esc>hJxP$
"(unused)"map <enter><del><del> a"<enter>. "<esc>hJxP$
"(unused)"imap <enter><del> \n"<enter>. "
"(unused)"imap <enter><del><del> "<enter>. "
""Review:
""""" Auto quoting-return:
""""imap <bs><cr> \n<esc>?'\\|"<cr>vyg;lpo. <esc>pa
""""" Auto quoting-return without cr:
""""imap <bs><cr><cr> <esc>?'\\|"<cr>vyg;po. <esc>pa

"}}}

"<CTRL-T> Title underline with user-given character: {{{
"(Unused)"map <c-t> yyp:s/[:\s<space>]*$//<enter>0/[^\/\*\- \"]<enter>v$?\w<enter>r
"}}}

"}}}
