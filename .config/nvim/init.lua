
-- General options:
require("vim-options")

-- Lazy plugin manager:
require("config.lazy")


-- Navigation:
require("navigation")


-- Screen Terminal (<F12>):
require 'custom.persistent_terminal'

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
vim.cmd("so ~/.vim/vimrc_files/git.vim")
vim.cmd("so ~/.vim/vimrc_files/mappings.vim")
vim.cmd("so ~/.vim/vimrc_files/formatting.vim")
vim.cmd("so ~/.vim/vimrc_files/run.vim")
vim.cmd("so ~/.vim/vimrc_files/netrw.vim")
-- vim.cmd("so ~/.vim/vimrc_files/misc.vim")

-- vim.cmd("so ~/.vim/vimrc_files/python.vim")
-- vim.cmd("so ~/.vim/vimrc_files/oldStuff.vim")
vim.cmd("so ~/.vim/vimrc_files/emoji.vim")

-- vim.cmd("so ~/.vim/vimrc_files/hilight.vim")
