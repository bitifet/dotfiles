
" Git:
command! -nargs=* Gitdiff !git<space>diff<space><args><space>--color<space>%|less<space>-R
command! Gitstatus !git<space>status<space>%
command! Gitlog !git<space>log<space>--color<space>%|less<space>-R
command! Gitadd !git<space>add<space>%

