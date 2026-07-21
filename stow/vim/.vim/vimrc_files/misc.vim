

" Auto-append insertion mode:
:command! Iappend :inoremap <enter> <esc>jA

" Auto-append insertion mode + initial space:
:command! Iappends :inoremap <enter> <esc>jA<space>

" Reset auto-append insertion modes:
:command! Noiappend :iunmap <enter>

