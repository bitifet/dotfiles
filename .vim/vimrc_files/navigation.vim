
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
" Ctrl+... (Move)
" ------------------------
map ñh :tabp<enter>
map ñl :tabn<enter>
map ñ<c-h> :tabm<space>-1<enter>
map ñ<c-l> :tabm<space>+1<enter>


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
"  Miscellaneous
" ------------------------

" ñu - Buffer change undo / switch.
nmap ñu :buf<space>#<cr>

" gf in tabs:
nmap ñgf :tabedit<space><cfile><CR>

" ñy "Cross-session" yank.
noremap ñy :w!<space>~/.vim/clipboard.txt<enter>

" ñp "Cross-session" paste.
noremap ñp :r<space>~/.vim/clipboard.txt<enter>

" ññ Cursor row+column switch.
nmap ññ :silent set<space>cursorline!<space>cursorcolumn!<enter>



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
" "Goto File" (gf): Ñgf / ÑgF
" ------------------------
set splitbelow
nmap Ñ- <c-w><c-s>
nmap Ñ_ :new<enter>
nmap Ñ__ Ñ_ñJ
nmap Ñgf :new<space><cfile><CR>
set splitright
nmap Ñ\| <c-w><c-v>
nmap Ñ! :vnew<enter>
nmap Ñ!! Ñ!ñJ
nmap ÑgF :vnew<space><cfile><CR>

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
" # Resize:
" # (Repeatable) Resize with Meta-hjkl:
" bind -r M-h send-keys ÑH
" bind -r M-j send-keys ÑJ
" bind -r M-k send-keys ÑK
" bind -r M-l send-keys ÑL
" -----------------------------------------------

