local M = {}

POSITION_AT = 'OLD'
LAST_JUMP = 'None'

local function go_to_buffer_by_name(buf_name)
  local bufnr = vim.fn.bufnr(buf_name)
  if bufnr > 0 then
    vim.api.nvim_set_current_buf(bufnr)
    print('Switched to buffer:', buf_name)
  else
    print('Buffer not found:', buf_name)
  end
end

fancy_gd = function()
  -- save old position
  old_row_tmp, old_column_tmp = unpack(vim.api.nvim_win_get_cursor(0))
  old_buf_tmp = vim.api.nvim_buf_get_name(0)

  -- go to def
  vim.lsp.buf.definition()
  -- check if old position is same as old -- meanig gd did not work
  --
  -- c_row, c_column = unpack(vim.api.nvim_win_get_cursor(0))
  -- c_buf = vim.api.nvim_buf_get_name(0)
  -- if old_row_tmp == c_row and old_column_tmp == c_column and old_buf_tmp == c_buf then
  -- vim.notify('Falied gd' .. old_row_tmp .. c_row, vim.log.levels.INFO)
  -- else
  POSITION_AT = 'NEW'
  LAST_JUMP = 'GD'
  old_row = old_row_tmp
  old_column = old_column_tmp
  old_buf = old_buf_tmp
  vim.notify('Success gd', vim.log.levels.INFO)
  -- end
end

vim.api.nvim_create_autocmd('BufLeave', {
  callback = function()
    LAST_JUMP = 'buffer'
  end,
})
-- vim.api.nvim_create_autocmd('BufEnter', {
--   callback = function()
--     new_row, new_column = unpack(vim.api.nvim_win_get_cursor(0))
--     new_buf = vim.api.nvim_buf_get_name(0)
--     POSITION_AT = 'OLD'
--     LAST_JUMP = 'buffer'
--   end,
-- })

gd_go_back = function()
  if LAST_JUMP == 'None' then
  elseif LAST_JUMP == 'buffer' then
    -- Go to alternative file
    -- vim.api.nvim_feedkeys('<C-^>', 'n', true)
    vim.cmd 'e #'
  elseif POSITION_AT == 'NEW' then
    -- save new position
    new_row, new_column = unpack(vim.api.nvim_win_get_cursor(0))
    new_buf = vim.api.nvim_buf_get_name(0)
    -- go back to old position
    go_to_buffer_by_name(old_buf)
    vim.api.nvim_win_set_cursor(0, { old_row, old_column }) -- Column is 0-based in the API

    POSITION_AT = 'OLD'
    -- LAST_JUMP = 'GD'
    vim.notify('going to old_row', vim.log.levels.INFO)
  elseif POSITION_AT == 'OLD' then
    -- save new position
    old_row, old_column = unpack(vim.api.nvim_win_get_cursor(0))
    old_buf = vim.api.nvim_buf_get_name(0)
    go_to_buffer_by_name(new_buf)
    vim.api.nvim_win_set_cursor(0, { new_row, new_column }) -- Column is 0-based in the API
    POSITION_AT = 'NEW'
    -- LAST_JUMP = 'GD'
    vim.notify('going to new row', vim.log.levels.INFO)
  end
end

vim.keymap.set('n', 'gd', function()
  fancy_gd()
end)
vim.keymap.set('n', '<tab>', function()
  gd_go_back()
end)
-- vim.keymap.set('n', '<S-tab>', function()
--   vim.cmd 'e #'
--   -- vim.api.nvim_feedkeys('<C-^>', 'n', true)
-- end)
vim.keymap.set('n', '<S-tab>', '<C-^>')

return M
