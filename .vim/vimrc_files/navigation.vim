
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
" ñ: Buffer and tab management.

" ------------------------
" (ñ)
" hjkl - hl (left - right)
" Tab-Left - Tab-Right
" ------------------------
map ñh :tabp<enter>
map ñl :tabn<enter>


" ------------------------
" (ñ)
" hjkl - jk (down - up)
" (Up) - New tab:
"   k: Netrw in current file directory.
"   K: Unnamed emtpy buffer.
" (Down) - Switch buffer (in current tab):
"   j: Open bufexplorer (Requires bufexplorer plugin)
"   J: Netrw in current file directory.
"   (TODO) JJ: New unnamed buffer.
"   J%: (Hint) New nammed buffer (will be asked).
" ------------------------
nmap ñk :tabe<space>%:p:h<cr>
nmap ñK :tabe<cr>
nmap ñj \be
nmap ñJ :e<space>%:p:h<cr>


" ------------------------
" ñu - Buffer change undo / switch.
" ------------------------
nmap ñu :buf<space>#<cr>



" ==========
" Ñ-commands
" ==========
" Ñ: Window management.

" --------------------------------
" tmux-pane-like window shortcuts:
" --------------------------------

" ------------------------
" Split (horizntally / vertically):
" Same file: '-' / '|' (tmux-like)
" New buffer: '_' / '!'
" Netrw in current file directory: '__' / '!!'
" ------------------------
set splitright
set splitbelow
nmap Ñ- <c-w><c-s>
nmap Ñ_ :new<enter>
nmap Ñ__ Ñ_ñJ
nmap Ñ\| <c-w><c-v>
nmap Ñ! :vnew<enter>
nmap Ñ!! Ñ!ñJ

" Close (current / all other) windows:
nmap Ñx <c-w>c
nmap ÑX <c-w>o

" Window navigation (hjkl)
nmap Ñh <c-w>h
nmap Ñj <c-w>j
nmap Ñk <c-w>k
nmap Ñl <c-w>l

" Window resizing (hjkl)
nmap ÑH :vertical<space>resize<space>-1<enter>
nmap ÑJ :resize<space>+1<enter>
nmap ÑK :resize<space>-1<enter>
nmap ÑL :vertical<space>resize<space>+1<enter>
" HINT: Tmux config to make resizing repeatable:
" -----------------------------------------------
" FIXME!! (update me)
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

