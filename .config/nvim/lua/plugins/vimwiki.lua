return {
    {
        "vimwiki/vimwiki",
        lazy = false, -- Ensure it loads immediately
        config = function()
            vim.g.vimwiki_list = {
                {
                    path = os.getenv("HOME") .. "/vimwiki/", -- Robust home dir
                    syntax = "markdown",
                    ext = ".md",
                },
            }
            vim.g.vimwiki_ext2syntax = { [".md"] = "markdown" } -- Reinforce Markdown
        end,
    },
}
