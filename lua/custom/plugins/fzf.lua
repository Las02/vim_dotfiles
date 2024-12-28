return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- calling `setup` is optional for customization
    require('fzf-lua').setup {}
  end,
  keys = function()
    return {
      { '<leader>s', require('fzf-lua').lsp_live_workspace_symbols, desc = 'Find Symbols' },
      { '<leader>f', require('fzf-lua').files, desc = 'Find Files' },
      { '<leader>w', require('fzf-lua').live_grep_native, desc = 'grep' },
      {
        ',f',
        function()
          require('fzf-lua').files { cwd = '~' }
        end,
        desc = 'files root',
      },
      {
        ',w',
        function()
          require('fzf-lua').live_grep_native { cwd = '~' }
        end,
        desc = 'grep files root',
      },
    }
  end,
}
