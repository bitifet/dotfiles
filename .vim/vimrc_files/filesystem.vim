
" gf in tabs:
map gf :tabedit <cfile><CR>
map Gf :tabedit <cfile><tab><CR>

" [F2]: Open current dir. Shift=>In new tab. Ctrl=>Open current file's directory.
map <F2> :e .<cr>
map <S-F2> :tabedit .<cr>
map <C-F2> :e %:h<cr>
map <C-S-F2> :tabedit %:h<cr>

" [F10]: "Exit file" (close and open its directory):"{{{
map <F10> :e<space>%:p:h<cr>
"}}}


" Fielutils:
command! Diff :w<space>!diff<space>-<space>%|less
command! Recovered :!<space>rm<space>$(echo<space>%<space>|perl<space>-pe<space>'s/^(.*\/)?\.?(.*)$/\1.\2.swp\*/')
command! Path :!echo<space>%:p

