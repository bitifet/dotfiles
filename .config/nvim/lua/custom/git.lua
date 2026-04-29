
-- Define a function to run git diff and display output in a new buffer
vim.api.nvim_create_user_command('Gitdiff', function(opts)
  -- Construct the git diff command with arguments
  local cmd = 'git diff ' .. (opts.args or '') .. ' --color=always %'

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(true, true) -- true: listed, true: scratch
  vim.api.nvim_buf_set_name(buf, 'Git Diff')

  -- Run the git diff command and capture output
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        -- Append the output to the buffer
        vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
      end
    end,
    on_exit = function()
      -- Set buffer options for better display
      vim.api.nvim_buf_set_option(buf, 'filetype', 'diff') -- Use diff syntax highlighting
      vim.api.nvim_buf_set_option(buf, 'modifiable', false) -- Make buffer read-only
      vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe') -- Wipe buffer when closed

      -- Open the buffer in a new window (e.g., vertical split)
      vim.api.nvim_command('vsplit')
      vim.api.nvim_win_set_buf(0, buf)
    end,
  })
end, { nargs = '*' }) -- Allow optional arguments

