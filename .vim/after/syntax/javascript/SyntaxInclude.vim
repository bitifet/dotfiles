

" Run Javascript thought Node.js:
" ===============================
" Run:
map <buffer> <f5> :!node<space>%<enter>
map <buffer> <c-f5> :silent<space>!tmux<space>split-window<space>-h<space>"node<space>%\|less<space>-R"<enter>
map <buffer> <a-f5> :silent<space>!tmux<space>split-window<space>-v<space>"node<space>%\|less<space>-R"<enter>
" Run + less
map <buffer> <f6> :!node<space>%\|less<space>-R<enter>
map <buffer> <c-f6> :silent<space>!tmux<space>split-window<space>-h<space>"node<space>%\|less<space>-R"<enter>
map <buffer> <a-f6> :silent<space>!tmux<space>split-window<space>-v<space>"node<space>%\|less<space>-R"<enter>
" JSON View thught less.
map <buffer> <f7> :!node<space>%\|underscore<space>print<space>--color\|less<space>-R<enter>
map <buffer> <c-f7> :silent<space>!tmux<space>split-window<space>-h<space>"node<space>%\|underscore<space>print<space>--color\|less<space>-R"<enter>
map <buffer> <a-f7> :silent<space>!tmux<space>split-window<space>-v<space>"node<space>%\|underscore<space>print<space>--color\|less<space>-R"<enter>
"
" Requires: https://www.npmjs.com/package/underscore-cli
"    $ sudo npm install -g underscore-cli
"
"
"    TODO: Experiment whith tmux splitting:
"       tmux splitw -v -p 50 bash
"       Investigate how to preserve split and send again commands.
