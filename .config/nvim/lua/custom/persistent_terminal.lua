local M = {}

local terminal_win = nil -- Store floating window ID
local screen_session = "nvim_" .. vim.fn.getpid()

function M.toggle_persistent_terminal()
  local bufname = vim.api.nvim_buf_get_name(0)  -- Get buffer name
  local filetype = vim.bo.filetype  -- Get current buffer's filetype
  local dir

  if filetype == "netrw" then
    dir = vim.b.netrw_curdir or vim.fn.getcwd()  -- Use netrw current directory or working directory
  elseif bufname == "" then
    dir = vim.fn.getcwd()  -- Use working directory for unnamed buffers
  else
    dir = vim.fn.fnamemodify(bufname, ":h")  -- Extract directory from file path
  end

  if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
    vim.defer_fn(function()
      vim.api.nvim_win_close(terminal_win, true)
      terminal_win = nil
    end, 100)
  else
    local buf = vim.api.nvim_create_buf(false, true)
    local opts = {
      relative = "editor",
      width = math.floor(vim.o.columns - 2),
      height = math.floor(vim.o.lines - 4),
      row = math.floor(2),
      col = math.floor(1),
      style = "minimal",
      border = "rounded",
    }
    terminal_win = vim.api.nvim_open_win(buf, true, opts)

    -- Start or attach to a persistent 'screen' session in the current directory
    vim.fn.termopen("cd " .. dir .. " && screen -UdRR " .. screen_session .. "; exit")

    vim.cmd("startinsert")
  end
end
vim.api.nvim_set_keymap("n", "<F12>", ":lua require'custom.persistent_terminal'.toggle_persistent_terminal()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<F12>", "<C-\\><C-n>:lua require'custom.persistent_terminal'.toggle_persistent_terminal()<CR>", { noremap = true, silent = true })

function M.check_screen_on_exit()
  local screen_status = vim.fn.system("screen -ls " .. screen_session)
  if string.find(screen_status, screen_session) then
    vim.ui.select(
      { "Yes", "No" },
      { prompt = "Screen session still active. Do you want to kill it?" },
      function(choice)
        if choice == "Yes" then
          vim.fn.system("screen -S " .. screen_session .. " -X quit && clear")
        end
      end
    )
  end
end

vim.api.nvim_create_autocmd("VimLeavePre", { callback = M.check_screen_on_exit })

return M

