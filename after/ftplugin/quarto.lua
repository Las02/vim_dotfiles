vim.keymap.set('n', '<leader>q', function()
  -- 1. Get the current cursor row (1-indexed)
  local row = vim.api.nvim_win_get_cursor(0)[1]

  local lines = {
    '``` {python}',
    '',
    '```',
  }

  -- 2. Replace the current line with the code block
  -- (Using row-1 because the buffer API is 0-indexed)
  vim.api.nvim_buf_set_lines(0, row - 1, row, false, lines)

  -- 3. Set the cursor exactly to the empty middle line
  -- (The original line is 'row', so the middle line is 'row + 1')
  vim.api.nvim_win_set_cursor(0, { row + 1, 0 })

  -- 4. Enter insert mode at the end of the line to respect auto-indent
  -- vim.cmd 'startinsert!'
end, { desc = 'Insert Python code block exactly at cursor' })
