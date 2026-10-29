return {
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        init = function()
            -- The dotfiles use the tmux prefix (Tab) followed by hjkl.
            -- Avoid adding vim-tmux-navigator's default Ctrl-hjkl mappings.
            vim.g.tmux_navigator_no_mappings = 1
            -- Stop at the edge of the tmux layout rather than wrapping around.
            vim.g.tmux_navigator_no_wrap = 1
        end,
    },
}
