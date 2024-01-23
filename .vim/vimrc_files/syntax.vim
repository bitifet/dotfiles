
filetype plugin indent on
syntax on

" Syntax blocks:
" ==============
"  ( http://www.vim.org/scripts/script.php?script_id=4168 )

" Global:
" -------
autocmd Syntax * call SyntaxRange#Include('@@js@@', '@@/js@@', 'javascript', 'NonText')
autocmd Syntax * call SyntaxRange#Include('@@sql@@', '@@/sql@@', 'sql', 'NonText')
autocmd Syntax * call SyntaxRange#Include('@@php@@', '@@/php@@', 'php', 'NonText')
autocmd Syntax * call SyntaxRange#Include('@@sh@@', '@@/sh@@', 'sh', 'NonText')
autocmd Syntax * call SyntaxRange#Include('@@html@@', '@@/html@@', 'html', 'NonText')
autocmd Syntax * call SyntaxRange#Include('@@pug@@', '@@/pug@@', 'pug', 'NonText')
autocmd Syntax * call SyntaxRange#Include('@@python@@', '@@/python@@', 'python', 'NonText')
autocmd Syntax * call SyntaxRange#Include('@@markdown@@', '@@/markdown@@', 'markdown', 'NonText')
"autocmd Syntax * call SyntaxRange#Include('@@csv@@', '@@/csv@@', 'csv', 'NonText')

" Markdown:
" ---------
autocmd Syntax markdown call SyntaxRange#Include('^\s*```javascript\s*$', '^\s*```\s*$', 'javascript', 'NonText')
autocmd Syntax markdown call SyntaxRange#Include('^\s*```json\s*$', '^\s*```\s*$', 'json', 'NonText')
autocmd Syntax markdown call SyntaxRange#Include('^\s*```jsonc\s*$', '^\s*```\s*$', 'jsonc', 'NonText')
autocmd Syntax markdown call SyntaxRange#Include('^\s*```sql\s*$', '^\s*```\s*$', 'sql', 'NonText')
autocmd Syntax markdown call SyntaxRange#Include('^\s*```php\s*$', '^\s*```\s*$', 'php', 'NonText')
autocmd Syntax markdown call SyntaxRange#Include('^\s*```sh\s*$', '^\s*```\s*$', 'sh', 'NonText')
autocmd Syntax markdown call SyntaxRange#Include('^\s*```html\s*$', '^\s*```\s*$', 'html', 'NonText')
autocmd Syntax markdown call SyntaxRange#Include('^\s*```pug\s*$', '^\s*```\s*$', 'pug', 'NonText')
"autocmd Syntax markdown call SyntaxRange#Include('^\s*```csv\s*$', '^\s*```\s*$', 'csv', 'NonText')

" Fix Wrong behaviour with backticks without language specification:
autocmd Syntax markdown call SyntaxRange#Include('^\s*```\s*$', '^\s*```\s*$', 'none', 'NonText')


" Syntax fixings:
" ===============
autocmd Syntax sql call set commentstring=--%s
