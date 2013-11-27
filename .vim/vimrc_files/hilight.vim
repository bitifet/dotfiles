
syntax on
syn sync fromstart
":syntax include @SQL syntax/php.vim
"syntax region sqlSnip matchgroup=Snip start="@begin=sql@" end="@end=sql@" contains=@SQL
"hi link Snip SpecialComment

let php_sql_query=1
let php_htmlInStrings=1


set background=dark
