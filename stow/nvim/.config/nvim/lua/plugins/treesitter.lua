return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').setup {
                install_dir = vim.fn.stdpath('data') .. '/site',
            }

            -- Enable highlighting for all treesitter filetypes
            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })

            -- Install parsers (async: sync via TSInstallSync in post_install)
            require('nvim-treesitter').install {
                'lua', 'javascript', 'python', 'bash', 'sql',
                'json', 'yaml', 'toml', 'markdown', 'vim', 'query',
                'html', 'css', 'markdown_inline', 'pug'
            }
        end
    }
}
