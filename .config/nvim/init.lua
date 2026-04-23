
-- General options:
require("vim-options")

-- Lazy plugin manager:
require("config.lazy")


-- Navigation:
require("navigation")


-- Open the today's drafts directory through drafts script:
vim.api.nvim_create_user_command('Draft', function()
  vim.cmd('tabedit ' .. vim.fn.system('drafts'))
end, {})



-- Function to run visually selected code though an interpreter determined by the current file type:
-- Equivalent to, for instance, running :'<,'>!python3 in a python file.
function _G.run_selected_code()
    local filetype = vim.bo.filetype
    local interpreter = vim.g.interpreters[filetype]
    if interpreter == nil then
        print("No interpreter found for filetype: " .. filetype)
        return
    end
    vim.cmd("'<,'>!" .. interpreter)
end


-- Define the interpreters table
vim.g.interpreters = {
    python = 'python3',
    lua = 'lua',
    sh = 'bash',
    javascript = 'node',
    -- Add more mappings as needed
}

-- Map <F5> in visual mode to run the selected code
vim.api.nvim_set_keymap('v', '<F5>', '<Esc>:lua run_selected_code()<CR>', { noremap = true, silent = true })

-- Map <F5> in normal mode to visually select the inner paragraph and run the selected code
vim.api.nvim_set_keymap('n', '<F5>', 'vip<Esc>:lua run_selected_code()<CR>', { noremap = true, silent = true })


-- Screen Terminal (<F12>):
require 'custom.persistent_terminal'

-- require 'custom.bullet'


-- Custom git commands:
--require 'custom.git'

-- vim.api.nvim_create_autocmd("VimLeavePre", {
--     callback = function()
--         local choice = vim.fn.confirm("Are you sure you want to exit?", "&Yes\n&No", 2)
--         if choice ~= 1 then
--             vim.cmd("qa!")
--         else
--             vim.cmd("tabedit foo")
--             vim.cmd("w")
--         end
--     end,
-- })






-- TODO: surround


-- --vim.cmd("so ~/.vim/vimrc_files/plugins.vim")

--vim.cmd("so ~/.vim/vimrc_files/navigation.vim")





vim.cmd("so ~/.vim/vimrc_files/csv.vim")
vim.cmd("so ~/.vim/vimrc_files/svn.vim")
-- vim.cmd("so ~/.vim/vimrc_files/git.vim")
vim.cmd("so ~/.vim/vimrc_files/mappings.vim")
vim.cmd("so ~/.vim/vimrc_files/formatting.vim")
-- vim.cmd("so ~/.vim/vimrc_files/run.vim") -- REVEIW!!!: (overlaps F2)
vim.cmd("so ~/.vim/vimrc_files/netrw.vim")
-- vim.cmd("so ~/.vim/vimrc_files/misc.vim")

-- vim.cmd("so ~/.vim/vimrc_files/python.vim")
-- vim.cmd("so ~/.vim/vimrc_files/oldStuff.vim")
vim.cmd("so ~/.vim/vimrc_files/emoji.vim")

-- vim.cmd("so ~/.vim/vimrc_files/hilight.vim")
