return {
  'chentoast/marks.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function()
    require('marks').setup {
      -- whether to map keybinds or not. default true
      default_mappings = false,
    }
  end,
}
