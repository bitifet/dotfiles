return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = {
                    "lua", "javascript", "python", "bash", "sql",
                    "go", "ruby", "java", "php", "json", "yaml",
                    "toml", "markdown", "vim", "query", "html", "css",
                },
                ensure_installed_sync = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
