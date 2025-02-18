return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require('lualine').setup({
            options = {
                config = 'dracula'
            }
            , sections = {
                lualine_c = {
                    {
                        'filename',
                        file_status = true,
                        shorting_target = 40,
                        path = 1
                    }
                }
            }
        })
    end
}
