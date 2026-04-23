return {
    {
        "github/copilot.vim"
        , config = function()
            -- Disable default <Tab> mapping
            vim.g.copilot_no_tab_map = true
            -- Custom key mapping for accepting Copilot suggestions
            vim.api.nvim_set_keymap("i", "<M-CR>", 'copilot#Accept("<C-Cr>")', { silent = true, expr = true })
            -- Accept next word (Alt+Right Arrow alternative)
            vim.keymap.set('i', '<M-l>', '<Plug>(copilot-accept-word)')
            -- Undo word acceptance (reverse of Alt+l)
            vim.keymap.set('i', '<M-h>', '<esc>bdwa')
            -- Cycle suggestions: Alt+j = previous, Alt+k = next
            vim.keymap.set('i', '<M-j>', '<Plug>(copilot-previous)')
            vim.keymap.set('i', '<M-k>', '<Plug>(copilot-next)')
        end
    }
}
