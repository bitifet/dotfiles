

" Geobase:
map gzshowloc yiwoselect<space>*<space>from<space>api.showloc(<esc>p$a);<esc>V:!pg<space>


" Datamapper:
""""noremap <c-c> :s/^\s*/"/\|'<,'>s/\s*\|\s*/";"/g\|'<,'>s/\s*$/"/\|'<,'>g/^"[-+]*"$/d<enter>
""""noremap <c-m> ToMap :s/^\s\+\*\s\+/<tab>'/|'<,'>s/\s\+->\s*/' => '/|'<,'>s/\s*$/',/
""command! ToMap :s/^\s\+\*\s\+/<tab>'/|'<,'>s/\s\+->\s*/' => '/|'<,'>s/\s*$/',/

