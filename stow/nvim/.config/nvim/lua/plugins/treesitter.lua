return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua", "javascript", "python", "bash", "sql",
                    "go", "ruby", "java", "php", "json", "yaml",
                    "toml", "markdown", "vim", "query", "html", "css",
                    "markdown_inline", "pug"
                },
                sync_install = true,
                auto_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
