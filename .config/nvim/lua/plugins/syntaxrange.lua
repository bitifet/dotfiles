-- Syntax blocks:
-- ==============
--  ( http://www.vim.org/scripts/script.php?script_id=4168 )
return {
    {
        "inkarkat/vim-SyntaxRange"
        , config = function()

            -- Workarounds:
            -- ------------
            vim.cmd('let main_syntax = "" " Prevent var not defined error while including some syntax files')

            -- Global:
            -- -------
            vim.cmd("autocmd Syntax * call SyntaxRange#Include('@@js@@', '@@/js@@', 'javascript', 'NonText')")
            vim.cmd("autocmd Syntax * call SyntaxRange#Include('@@sql@@', '@@/sql@@', 'sql', 'NonText')")
            vim.cmd("autocmd Syntax * call SyntaxRange#Include('@@php@@', '@@/php@@', 'php', 'NonText')")
            vim.cmd("autocmd Syntax * call SyntaxRange#Include('@@sh@@', '@@/sh@@', 'sh', 'NonText')")
            vim.cmd("autocmd Syntax * call SyntaxRange#Include('@@html@@', '@@/html@@', 'html', 'NonText')")
            vim.cmd("autocmd Syntax * call SyntaxRange#Include('@@pug@@', '@@/pug@@', 'pug', 'NonText')")
            vim.cmd("autocmd Syntax * call SyntaxRange#Include('@@python@@', '@@/python@@', 'python', 'NonText')")
            vim.cmd("autocmd Syntax * call SyntaxRange#Include('@@markdown@@', '@@/markdown@@', 'markdown', 'NonText')")
            --autocmd Syntax * call SyntaxRange#Include('@@csv@@', '@@/csv@@', 'csv', 'NonText')

            -- Markdown:
            -- ---------
            vim.cmd("autocmd Syntax markdown call SyntaxRange#Include('^\\s*```javascript\\s*$', '^\\s*```\\s*$', 'javascript', 'NonText')")
            vim.cmd("autocmd Syntax markdown call SyntaxRange#Include('^\\s*```json\\s*$', '^\\s*```\\s*$', 'json', 'NonText')")
            vim.cmd("autocmd Syntax markdown call SyntaxRange#Include('^\\s*```jsonc\\s*$', '^\\s*```\\s*$', 'jsonc', 'NonText')")
            vim.cmd("autocmd Syntax markdown call SyntaxRange#Include('^\\s*```sql\\s*$', '^\\s*```\\s*$', 'sql', 'NonText')")
            vim.cmd("autocmd Syntax markdown call SyntaxRange#Include('^\\s*```php\\s*$', '^\\s*```\\s*$', 'php', 'NonText')")
            vim.cmd("autocmd Syntax markdown call SyntaxRange#Include('^\\s*```sh\\s*$', '^\\s*```\\s*$', 'sh', 'NonText')")
            vim.cmd("autocmd Syntax markdown call SyntaxRange#Include('^\\s*```html\\s*$', '^\\s*```\\s*$', 'html', 'NonText')")
            vim.cmd("autocmd Syntax markdown call SyntaxRange#Include('^\\s*```pug\\s*$', '^\\s*```\\s*$', 'pug', 'NonText')")
            vim.cmd("autocmd Syntax markdown call SyntaxRange#Include('^\\s*```css\\s*$', '^\\s*```\\s*$', 'css', 'NonText')")
            --autocmd Syntax markdown call SyntaxRange#Include('^\\s*```csv\\s*$', '^\\s*```\\s*$', 'csv', 'NonText')

            -- Fix Wrong behaviour with backticks without language specification:
            vim.cmd("autocmd Syntax markdown call SyntaxRange#Include('^\\s*```\\s*$', '^\\s*```\\s*$', 'none', 'NonText')")

        end
    }
}
