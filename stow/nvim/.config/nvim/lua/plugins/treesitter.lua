return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" }, -- Ensure plugin loads for files
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = {
                    "lua", "javascript", "python", "bash", "sql",
                    "go", "ruby", "java", "php", "json", "yaml",
                    "toml", "markdown", "vim", "query", "html", "css",
                    "markdown_inline", "pug"
                },
                ensure_installed_sync = true,
                highlight = { enable = true },
                injections = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
