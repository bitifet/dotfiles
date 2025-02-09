return {
    -- plugins/telescope.lua:
    -- Requires: sudo apt install ripgrep
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>fi', builtin.current_buffer_fuzzy_find, { desc = 'Telescope find inside buffer' })
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope old files' })
            vim.keymap.set('n', '<leader>f:', builtin.command_history, { desc = 'Telescope command history' })
            vim.keymap.set('n', '<leader>fs', builtin.search_history, { desc = 'Telescope search history' })
            vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Telescope search marks' })
            vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Telescope search registers' })
            vim.keymap.set('n', '<leader>fM', builtin.man_pages, { desc = 'Telescope search man pages' })
            vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Telescope git commits' })
        end
    }
}
