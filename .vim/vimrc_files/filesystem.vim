
" lsb for bufexplorer (in current/new tab):
nmap bls \be
nmap tbls :tabe<cr>\be

" buffer change "undo":
nmap bu :buf<space>#<cr>


" ls to open current file's directory (in current/new tab):
nmap ls :e<space>%:h<cr>
nmap tls :tabe<space>%:h<cr>



" gf in tabs:
"map gf :tabedit<space><cfile><CR>
"map Gf :tabedit<space><cfile><tab><CR>

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

