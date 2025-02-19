return {
    {
        -- https://github.com/williamboman/mason.nvim
        "williamboman/mason.nvim"
        , config = function()
            require("mason").setup()
        end
    }
    , {
        -- https://github.com/williamboman/mason-lspconfig.nvim
        "williamboman/mason-lspconfig.nvim"
        , config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    -- "bashls",
                    "html",
                    "cssls",
                    -- "jqls",
                    -- "spectral", -- JSON / Yaml
                    "remark_ls", -- Markdown
                    --"pylsp",
                    "sqlls",
                }
            })
        end
    }
    , {
        -- https://github.com/neovim/nvim-lspconfig
        "neovim/nvim-lspconfig"
        , config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.ts_ls.setup({})
            -- lspconfig.bash_ls.setup({})
            lspconfig.html.setup({})
            lspconfig.cssls.setup({})
            -- lspconfig.jqls.setup({})
            -- lspconfig.spectral.setup({})
            lspconfig.remark_ls.setup({})
            --lspconfig.pylsp.setup({})
            lspconfig.sqlls.setup({})
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {})
        end
    }
}

