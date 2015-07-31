

" Geobase:
map gzshowloc yiwoselect<space>*<space>from<space>api.showloc(<esc>p$a);<esc>V:!pg<space>

" Forever:
nmap <f2> :!forever restart 
nmap <f2><enter> :!forever restart 0<enter>
nmap <f3> :!forever logs 0<enter>
nmap <f3><enter> :!forever list<enter>


" Datamapper:
""""noremap <c-c> :s/^\s*/"/\|'<,'>s/\s*\|\s*/";"/g\|'<,'>s/\s*$/"/\|'<,'>g/^"[-+]*"$/d<enter>
""""noremap <c-m> ToMap :s/^\s\+\*\s\+/<tab>'/|'<,'>s/\s\+->\s*/' => '/|'<,'>s/\s*$/',/
""command! ToMap :s/^\s\+\*\s\+/<tab>'/|'<,'>s/\s\+->\s*/' => '/|'<,'>s/\s*$/',/

