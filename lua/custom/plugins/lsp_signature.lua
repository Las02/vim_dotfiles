return {
  'ray-x/lsp_signature.nvim',
  event = 'LspAttach',
  lazy = true,
  opts = {},
  config = function()
    require('lsp_signature').on_attach {
      hint_prefix = '',
      -- hint_enable = false,
      floating_window = false,
    }
  end,
}
