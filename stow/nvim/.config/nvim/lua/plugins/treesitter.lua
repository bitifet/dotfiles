return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        build = ':TSUpdate',
        lazy = false,
        config = function()
            local ok, configs = pcall(require, 'nvim-treesitter.configs')
            if not ok then
                vim.notify('nvim-treesitter not loaded. Run :Lazy sync nvim-treesitter', vim.log.levels.WARN)
                return
            end
            configs.setup({
                ensure_installed = {
                    'lua', 'javascript', 'python', 'bash', 'sql',
                    'json', 'yaml', 'toml', 'markdown', 'vim', 'query',
                    'html', 'css', 'markdown_inline', 'pug'
                },
                sync_install = true,
                auto_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
