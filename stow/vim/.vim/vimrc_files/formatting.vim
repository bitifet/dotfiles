
" Json:
:command! -range Json <line1>,<line2>:!python3<space>-m<space>json.tool

" Csv: (Convert selection to from SQL output to CSV)
:command! -range Csv <line1>,<line2>:s/^\s*/"/|<line1>,<line2>:s/\s*|\s*/";"/g|<line1>,<line2>:s/\s*$/"/|<line1>,<line2>:g/^"[-+]*"$/d

" F8 key -> Switch visually selected text between PUG and HTML:
:vmap <F8> :!carlino<enter>

" F8 key -> Visually select all text (with no blank lines) under cursor and
" switch between PUG and HTML:
:nmap <F8> vip<F8>j

" Qjs: (Quote selection as javascript string)
:command! -range Qjs <line1>,<line2>:s/^/+ "/|<line1>,<line2>:s/\s*$/\\n"/g|<line1>:s/+\s//|:noh

" ,, Convert common '|' separated SQL output to comma-separted list."{{{
" (suitable as other SQL input, like column names)
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ,, :s/\s*\|\s*/,<space>/g<enter>:noh<enter>
" Same in visual mode, but multiline:
vmap ,, :s/[<space>\n]*\|[<space>\n]*/,<space>/g<enter>:noh<enter>

" Same with only spaces:
nmap ,,, :s/\(.\)\s\+\(.\)/\1,<space>\2/g<enter>:noh<enter>
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
