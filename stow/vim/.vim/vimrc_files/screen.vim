
" [F12]: Attached Screen session: {{{
" ==============================

" Build mapping: {{{
" cd $(dirname %:p) --> Change to current file's directory.
" screen
"	-U	-> Run in UTF-8 mode.
"	-d	-> Deatach if previously attached.
"	-dRR vim_$(basename %:p)
"		-> Use current buffer file name as sessionname; then reattach it and, if necessary, detach or create it first. Use the first session if more than one session with same name are available.
"	-p %:p	-> Use current buffer file full path as preselected (if available) window.
"		* TODO: Create this window by default when not exists.
"	-c ~/.vim/screenrc
"		-> Use modified screenrc config file (see below).
"noremap <f12> :silent<space>!bash<space>-c<space>'cd<space>$(dirname<space>%:p);screen<space>-UdRR<space>vim_${PPID}<space>-e^qa<space>-p<space>"%"<space>-c<space>~/.vim/screenrc'<enter>:redraw!<enter>
"""""noremap <f12> :silent<space>!bash<space>-c<space>'cd<space>$(dirname<space>%:p);screen<space>-UdRR<space>vim_${PPID}<space>-p<space>"%"<space>-c<space>~/.vim/screenrc'<enter>:redraw!<enter>
noremap <f12> :silent<space>!vimPPID=$PPID<space>script<space>/dev/null<space>-c<space>'screen<space>-UdRR<space>vim_${vimPPID}<space>-c<space>~/.vim/screenrc'<enter>:redraw!<enter>
imap <f12> <esc><f12>a
" }}}

" Make screen session to be killed on exit and also prompting if dialog is installed: {{{
" ----------------------------------------------------------------------------------
autocmd VimLeave * !screen -ls vim_${PPID} | grep vim_${PPID} && dialog --yesno "Leave existing screen sessions alive?" 6 40 && screen -r vim_${PPID} || kill $(screen -ls vim_${PPID} | perl -ne 's/^.*?(\d{2,}).*$/\1/&&print') && clear
" }}}

" Prepare vim's screen configuration: {{{
" ----------------------------------
" Create ~/.vim directory if not already exists.
silent !mkdir -p ~/.vim
" Create/overwrite with user's ~/.screenrc if exists.
silent !cat ~/.screenrc > ~/.vim/screenrc 2>/dev/null
" Bind F12 to 'detach' command in screen.
silent !echo 'bindkey -k F2 detach' >> ~/.vim/screenrc
" .
silent !echo 'term xterm-256color' >> ~/.vim/screenrc
" Change default screen's escape key to CTRL-Q to avoid conflict if vim itself is running in other screen session.
""silent !echo 'escape ^qa' >> ~/.vim/screenrc


"silent !echo 'defbce "on"' >> ~/.vim/screenrc

"!echo "screen -t mysession 0 bash -c 'echo -ne \"\033[48;5;18m\"; exec bash'" >> ~/.vim/screenrc


" }}}

" }}}

" Screen Hint: {{{
" To execute something just before vim exists, you can use `VimLeave` autocommand,
" like that:
"    autocmd VimLeave * KillAllScreens
" (you must define KillAllScreens autocommand by yourself). About capturing vim's
" pid: use ``let g:vimpid=system('echo -n $PPID')+0''
" }}}

" Other hints: // {{{
" ===========

"On 2010-10-05 19:32 +0200, Joan Miquel Torres Rigo wrote:
"
"> I'm not sure because I never tryed this, but I think it is possible to
"> directly paste mouse selection within vim (or I thought to understood
"> that reading :help gui-selections). But I think this needs some setup.
"
"This is what I use. It's far from perfect but it's a start.
"
":command! -nargs=1 R :normal :set paste<cr>i<cr><esc>k:r <args><cr>:j!<cr>`[k:j!<cr>:set nopaste<cr>`^
"nnoremap <f9>   :R !xclip -o<cr>
"imap <f9>       <c-\><c-o><f9>
"
" }}}

