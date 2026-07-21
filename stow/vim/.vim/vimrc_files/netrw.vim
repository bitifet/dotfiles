
" Set tree view as default for netrw:
let g:netrw_liststyle = 3

" Reomve the banner:
let g:netrw_banner = 0

" Window width (when openning in the same tab with "v"):
let g:netrw_winsize = 85

" Netrw mappings:
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    noremap <buffer> o :Ntree<enter>
endfunction

