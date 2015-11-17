
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
" Requires: https://www.npmjs.com/package/underscore-cli
"    $ sudo npm install -g underscore-cli
"

"  Normal mode (whole -saved- file):
nmap <f5> :!%:p\|less -r<enter>
nmap <a-f5> :silent<space>!tmux<space>split-window<space>-h<space>"%:p\|less<space>-r"<enter>
nmap <c-f5> :silent<space>!tmux<space>split-window<space>-v<space>"%:p\|less<space>-r"<enter>
"vmap <f5> :'<,'>!node<space><enter> -- TO-DO: Capture shebang!!
"
" Fromatted JSON thought underscore (adding "Shift" key"):
nmap <s-f5> :!%:p\|underscore<space>print<space>--color\|less<space>-r<enter>
nmap <a-s-f5> :silent<space>!tmux<space>split-window<space>-h<space>"%:p\|underscore<space>print<space>--color\|less<space>-r"<enter>
nmap <c-s-f5> :silent<space>!tmux<space>split-window<space>-v<space>"%:p\|underscore<space>print<space>--color\|less<space>-r"<enter>
"vmap <s-f5> :'<,'>!node\|underscore<space>print<enter> -- TO-DO: Capture shebang!!


" TO-DO: Visual mode to tmux panes (without replacement).
"    vmap <a-f5> :'<,'>!tmux<space>split-window<space>-h<space>"%\|less<space>-R"<enter>
"    vmap <c-f5> :'<,'>!tmux<space>split-window<space>-v<space>"%\|less<space>-R"<enter>
"    FIXME: Below rows needs to be hacked to inject range as node stdin, not tmux itself.
"    NOTE: Experiment whith tmux splitting:
"       tmux splitw -v -p 50 bash
"       Investigate how to preserve split and send again commands.
