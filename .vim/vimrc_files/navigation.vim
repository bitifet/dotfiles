
"Misc:"{{{
nmap gip gi<esc>pa
nmap ygip yiwgip
"}}}

" Text blocks:{{{
map <c-j> /^\s*$<enter>:noh<enter>
map <c-k> ?^\s*$<enter>:noh<enter>
imap <c-j> <esc>/^\s*$<enter>:noh<enter>a
imap <c-k> <esc>?^\s*$<enter>:noh<enter>a
"}}}

" ===========
" ñ-commands:
" ===========
" Buffer and tab management.

" ------------------------
" hjkl - hl (left - right)
" Tab-Left - Tab-Right
" ------------------------
map ñh :tabp<enter>
map ñl :tabn<enter>
   imap <c-ñ>h <esc>:tabp<enter>
   imap <c-ñ>l <esc>:tabn<enter>


" ------------------------
" hjkl - jk (down - up)
" k: New tab (Open tab with netrw in current file directory.
" j: Switch buffer (Requires bufexplorer plugin)
" J: New buffer (Open netrw in current window)
" ------------------------
nmap ñk :tabe<space>%:p:h<cr>
nmap ñj \be
nmap ñJ :e<space>%:p:h<cr>
   imap <c-ñ>k <esc>:tabe<space>%:p:h<cr>
   imap <c-ñ>j <esc>\be
   imap <c-ñ>J :e<space>%:p:h<cr>


" ------------------------
" ñu - Buffer change undo / switch.
" ------------------------
nmap ñu :buf<space>#<cr>



" ==========
" ç commands
" ==========
" Window mangement.

" --------------------------------
" tmux-pane-like window shortcuts:
" --------------------------------

" Split (h/v):
nmap ç- <c-w><c-s>
nmap ç\| <c-w><c-v>

" Close (current / all other) windows:
nmap çx <c-w>c
nmap ç! <c-w>o

" Window navigation (hjkl)
nmap çh <c-w>h
nmap çj <c-w>j
nmap çk <c-w>k
nmap çl <c-w>l

" Window resizing (hjkl)
nmap çH :vertical<space>resize<space>-1<enter>
	nmap ÇH :vertical<space>resize<space>-1<enter>
nmap çJ :resize<space>+1<enter>
	nmap ÇJ :resize<space>+1<enter>
nmap çK :resize<space>-1<enter>
	nmap ÇK :resize<space>-1<enter>
nmap çL :vertical<space>resize<space>+1<enter>
	nmap ÇL :vertical<space>resize<space>+1<enter>
" HINT: Tmux config to make resizing repeatable:
" -----------------------------------------------
" # Resize:
" bind -r M-h send-keys çH
" bind -r M-j send-keys çJ
" bind -r M-k send-keys çK
" bind -r M-l send-keys çL
" -----------------------------------------------


" ==========
" Old stuff:
" ==========

" Tabs: {{{
"map <c-h> :tabp<enter>
"map <c-l> :tabn<enter>
"imap <c-h> <esc>:tabp<enter>
"imap <c-l> <esc>:tabn<enter>
" }}}

" Windows:"{{{
" (tmux-pane-like window shortcuts)
"nmap <c-w>- <c-w><c-s>
"nmap <c-w>\| <c-w><c-v>
"nmap <c-w>! <c-w>o
"noremap <c-w>K <c-w>-
"noremap <c-w>J <c-w>+
"}}}

