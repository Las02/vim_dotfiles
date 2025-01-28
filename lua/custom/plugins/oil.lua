-- return {
--   "tpope/vim-vinegar",
--   version = "*",
--   opts = {},
--   vscode = false,
--   config = function() end,
-- }
return {
  'stevearc/oil.nvim',
  version = '*',
  opts = { keymaps = { ['l'] = 'actions.select' } },
  vscode = false,
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  init = function()
    require('oil').setup { watch_for_changes = true, buf_options = {
      buflisted = false,
      bufhidden = 'hide',
    } }
  end,
}
