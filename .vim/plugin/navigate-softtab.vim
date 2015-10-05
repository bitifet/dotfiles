" Makes Vim navigate leading spaces like tabs.
" This is only active if softtabstop is set:
" set softtabstop=4   " Sets the number of columns for a TAB
" Supports <BS>, <Space>, x, and X in normal mode.
" source @ https://github.com/lampert/vim
" Paul Lampert 9/2013

function! SoftTabRight(key,eol)
    if &softtabstop == 0
        execute ":normal! ".a:key
        return
    endif
    let curpos=col(".")-1
    let l=getline(".")
    let llen=len(l)
    if curpos >= llen-1
        execute ":normal! ".a:eol
        return
    endif
    let countspace=match(l,"[^ ]")
    if (countspace<0)
        let countspace=llen-1
    endif
    if curpos >= countspace
        execute ":normal! ".a:key
        return
    endif
    let rtabstop = curpos / &softtabstop * &softtabstop + &softtabstop
    if (rtabstop > countspace)
        execute ":normal! ".repeat(a:key,countspace - curpos)
    else
        execute ":normal! ".repeat(a:key,rtabstop - curpos)
    endif
endfunction

function! SoftTabLeft(key,eol)
    if &softtabstop == 0
        execute ":normal! ".a:key
        return
    endif
    let curpos=col(".")-1
    if curpos == 0
        execute ":normal! ".a:eol
        return
    endif
    let countspace=match(getline("."),"[^ ]")
    if (countspace<0)
        let countspace=len(getline("."))-1
    endif
    if curpos > countspace
        execute ":normal! ".a:key
        return
    endif
    let nmove=curpos % &softtabstop
    if nmove == 0
        execute ":normal! ".repeat(a:key,&softtabstop)
    else
        execute ":normal! ".repeat(a:key,nmove)
    endif
endfunction

:nmap <silent> <C-H>   :call SoftTabLeft("\b","\b")
:nmap <silent> <Space> :call SoftTabRight("l","j0")
