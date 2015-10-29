

" <F5> Run Javascript thought Node.js:
" ====================================
"
"  * Normal mode:
"      -     -> Fullscreen view.
"      ALT   -> Display in new right side tmux pane.
"      CTRL  -> Display in new bottom tmux pane.
"      SHIFT -> Apply JSON formatting and syntax higlight thought underscore.
"      Allowed combinations:
"         SHIFT+ALT
"         SHIFT+CTRL
"  * Visual mode:
"      -     -> Selected text replacement.
"      SHIFT -> Apply JSON formatting thought underscore.
"
"  Normal mode (whole -saved- file):
nmap <buffer> <f5> :!node<space>%\|less<enter>
nmap <buffer> <a-f5> :silent<space>!tmux<space>split-window<space>-h<space>"node<space>%\|less<space>-R"<enter>
nmap <buffer> <c-f5> :silent<space>!tmux<space>split-window<space>-v<space>"node<space>%\|less<space>-R"<enter>
vmap <buffer> <f5> :'<,'>!node<space><enter>
"
" Fromatted JSON thought underscore (adding "Shift" key"):
nmap <buffer> <s-f5> :!node<space>%\|underscore<space>print<space>--color\|less<space>-R<enter>
nmap <buffer> <a-s-f5> :silent<space>!tmux<space>split-window<space>-h<space>"node<space>%\|underscore<space>print<space>--color\|less<space>-R"<enter>
nmap <buffer> <c-s-f6> :silent<space>!tmux<space>split-window<space>-v<space>"node<space>%\|underscore<space>print<space>--color\|less<space>-R"<enter>
vmap <buffer> <s-f5> :'<,'>!node\|underscore<space>print<enter>


" TO-DO: Visual mode to tmux panes (without replacement).
"vmap <buffer> <a-f5> :'<,'>!tmux<space>split-window<space>-h<space>"node<space>%\|less<space>-R"<enter>
"vmap <buffer> <c-f5> :'<,'>!tmux<space>split-window<space>-v<space>"node<space>%\|less<space>-R"<enter>
"FIXME: Below rows needs to be hacked to inject range as node stdin, not tmux itself.




"
" Requires: https://www.npmjs.com/package/underscore-cli
"    $ sudo npm install -g underscore-cli
"
"
"    TODO: Experiment whith tmux splitting:
"       tmux splitw -v -p 50 bash
"       Investigate how to preserve split and send again commands.
