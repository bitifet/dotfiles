
"Miscellaneous mappings:
""""""""""""""""""""""""

"Indentation: {{{
set tabstop=3
set shiftwidth=3
set autoindent

set listchars=tab:\|-
set list
"}}}

"<enter><del> mappings for quoted strings: {{{
"map <enter><del> a\n"<enter>. "<esc>hJxjy/\s*<enter>kP$
"map <enter><del><del> a"<enter>. "<esc>hJxjy/\s*<enter>kP$
"map <enter><del> a\n"<enter>. "<esc>Jx
"map <enter><del><del> a"<enter>. "<esc>Jx
map <enter><del> a\n"<enter>. "<esc>hJxP$
map <enter><del><del> a"<enter>. "<esc>hJxP$
imap <enter><del> \n"<enter>. "
imap <enter><del><del> "<enter>. "
""Review:
""""" Auto quoting-return:
""""imap <bs><cr> \n<esc>?'\\|"<cr>vyg;lpo. <esc>pa
""""" Auto quoting-return without cr:
""""imap <bs><cr><cr> <esc>?'\\|"<cr>vyg;po. <esc>pa

"}}}

"<CTRL-T> Title underline with user-given character: {{{
map <c-t> yyp:s/[:\s<space>]*$//<enter>0/[^\/\*\- \"]<enter>v$?\w<enter>r
"}}}



" Insert mode mappings:
" """""""""""""""""""""

" (()) Expands timestamp like (sat20101218-1217)
imap (()) (<enter><enter><esc>kV:!date<space>+\%a\%G\%m\%d-\%H\%M<enter>kJJi)<esc>F(lxf)lxa
imap (())<BS> (<enter><enter><esc>kV:!date<space>+\%a\%G\%m\%d<enter>kJJi)<esc>F(lxf)lxa

