-- return {}
return {
  'ray-x/lsp_signature.nvim',
  -- 'brunnre8/lsp_signature.nvim',
  event = 'LspAttach',
  lazy = true,
  opts = {},
  config = function()
    require('lsp_signature').on_attach {
      hint_prefix = '',
      hint_enable = false,
      toggle_key = '<C-s>',
      -- floating_window = false,
      handler_opts = {
        border = 'rounded', -- double, rounded, single, shadow, none, or a table of borders
      },
      max_height = 1, -- max height of signature floating_window
      -- max_width = 80,
      doc_lines = 0, -- crahses with max_height if this is not on
    }
  end,
}
