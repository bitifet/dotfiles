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
            vim.lsp.config["lua_ls"] = {
                cmd = { "lua_ls" },
                on_init = function(client)
                    client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {["lua-ls"] = { runtime = { version = "Lua 5.1" } } })
                end,
            }
            vim.lsp.config["ts_ls"] = { cmd = { "ts_ls" } }
            vim.lsp.config["html"] = { cmd = { "html" } }
            vim.lsp.config["cssls"] = { cmd = { "cssls" } }
            vim.lsp.config["remark_ls"] = { cmd = { "remark_ls" } }
            vim.lsp.config["sqlls"] = { cmd = { "sqlls" } }
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {})
        end
    }
}

