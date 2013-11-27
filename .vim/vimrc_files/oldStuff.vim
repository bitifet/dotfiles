"""""""""""""""""""""""""""""""""""""
" Old stuff pending to be reviewed...
"""""""""""""""""""""""""""""""""""""

" <S Home> / <S End> -> Find first previous/next blank line: {{{
noremap <S-Home> ?^\s*$<enter>
noremap <S-End> /^\s*$<enter>
" }}}

" <F5> Run: {{{
noremap <f5> :!./%
noremap <c-f5> :!./%<enter>
" }}}

" F6 -> Reformat open parentheses: {{{
noremap <F6> :s/\s*(\s*/ (/g<enter>
" }}}

" PHP / Postgres:"{{{
"""" noremap Pgescape :s/{/"<space>.<space>pg_escape_string<space>(/g\|'<,'>s/}/)<space>.<space>"/g<enter>
"}}}
