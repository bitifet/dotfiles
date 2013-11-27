
set foldmethod=marker

" Folding:
" Fold "simple" function:
:map z% <esc>:s/\s*$//<return>V$%zf


" ZZ -> Go to last change position, fold all and unfold up to cursor row:"{{{
" (also avoid default ZZ behaviour)
:map ZZ u<c-r>zMzx
"}}}

" Xml fold:
"au BufNewFile,BufRead *.xml,*.htm,*.html so ~/.vim/plugin/XMLFolding.vim

"set foldtext=MyFoldText()
"function! MyFoldText()
"	let n = v:foldend - v:foldstart + 1
"	let i = indent(v:foldstart)
"	let istr = ''
"	while i > 0
"		let istr = istr . ' '
"		let i = i - 1
"	endwhile
"	return istr . "+-" . v:folddashes . " " . n . " lines "
"endfunction



