
" <CTRL-C> Convert selection to from SQL output to CSV: {{{
noremap <c-c> :s/^\s*/"/\|'<,'>s/\s*\|\s*/";"/g\|'<,'>s/\s*$/"/\|'<,'>g/^"[-+]*"$/d<enter>
" Note: Initial "'<,'>" is automatically inserted by vim.
" }}}

" CSV plugin:
au! BufNewFile,BufRead *.csv setf csv
:let g:csv_delimiter = ";"

" DISABLED !!!" Highlight a column in csv text."{{{
"" :Csv 1    " highlight first column
"" :Csv 12   " highlight twelfth column
"" :Csv 0    " switch off highlight
"function! CSVH(colnr)
"  if a:colnr > 1
"    let n = a:colnr - 1
"    execute 'match Keyword /^\(\("\?\)[^,;]*\2[,;]\)\{'.n.'}\zs[^,;]*/'
"    execute 'normal! 0'.n.'f,'
"  elseif a:colnr == 1
"    match Keyword /^[^,;]*/
"    normal! 0
"  else
"    match
"  endif
"endfunction
"command! -nargs=1 Csv :call CSVH(<args>)
""}}}
