
" Fielutils:
command! Diff :w<space>!diff<space>-<space>%|less
command! Recovered :!<space>rm<space>$(echo<space>%<space>|perl<space>-pe<space>'s/^(.*\/)?\.?(.*)$/\1.\2.swp\*/')
command! Path :!echo<space>%:p

