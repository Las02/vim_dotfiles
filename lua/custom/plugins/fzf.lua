return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- calling `setup` is optional for customization
    require('fzf-lua').setup {
      marks = {
        marks = '%l', -- filter vim marks with a lua pattern
        -- for example if you want to only show user defined marks
        -- you would set this option as %a this would match characters from [A-Za-z]
        -- or if you want to show only numbers you would set the pattern to %d (0-9).
      },
    }
  end,
  keys = function()
    return {
      { '<leader>s', require('fzf-lua').lsp_live_workspace_symbols, desc = 'Find Symbols' },
      { '<leader>f', require('fzf-lua').files, desc = 'Find Files' },
      { '<leader>w', require('fzf-lua').live_grep_native, desc = 'grep' },
      { '<leader>m', require('fzf-lua').marks, desc = 'grep' },
      { '/', require('fzf-lua').live_grep_curbuf, desc = 'grep' },
      {
        '<leader>gf',
        function()
          require('fzf-lua').files { cwd = '~' }
        end,
        desc = 'files root',
      },
      {
        '<leader>gw',
        function()
          require('fzf-lua').live_grep_native { cwd = '~' }
        end,
        desc = 'grep files root',
      },
    }
  end,
}
