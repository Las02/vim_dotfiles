return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- calling `setup` is optional for customization
    require('fzf-lua').setup {
      marks = {
        -- marks = '%l', -- filter vim marks with a lua pattern
        marks = '%u', -- filter vim marks with a lua pattern
        -- for example if you want to only show user defined marks
        -- you would set this option as %a this would match characters from [A-Za-z]
        -- or if you want to show only numbers you would set the pattern to %d (0-9).
      },
    }
  end,
  keys = function()
    return {
      { '<leader>f', require('fzf-lua').files, desc = 'Find Files' },
      -- { '<leader>s', require('fzf-lua').lsp_document_symbols, desc = 'Find Symbols' },
      -- { '<leader>as', require('fzf-lua').lsp_live_workspace_symbols, desc = 'Find Symbols' },
      -- { '<leader>as', require('fzf-lua').lsp_incoming_calls, desc = 'Find Symbols' },
      -- { '<leader>w', require('fzf-lua').lgrep_curbuf, desc = 'grep' },
      -- { '<leader>aw', require('fzf-lua').live_grep_native, desc = 'grep' },
      { '<leader>w', require('fzf-lua').live_grep_native, desc = 'grep' },
      {
        '<leader>m',
        function()
          old_row_tmp, old_column_tmp = unpack(vim.api.nvim_win_get_cursor(0))
          old_buf_tmp = vim.api.nvim_buf_get_name(0)
          require('fzf-lua').marks {
            actions = {
              ['enter'] = function(selected, opts)
                require('fzf-lua').actions.goto_mark(selected)
                POSITION_AT = 'NEW'
                LAST_JUMP = 'GD'
                old_row = old_row_tmp
                old_column = old_column_tmp
                old_buf = old_buf_tmp
              end,
              ['ctrl-d'] = function()
                vim.cmd 'delmarks A-Z0-9'
                MARK_TO_SET = 1
              end,
            },
          }
        end,
        desc = 'marks',
      },
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
