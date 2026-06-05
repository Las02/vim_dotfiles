return {
  'folke/sidekick.nvim',
  lazy = false,
  opts = {
    -- add any options here
    nes = { enable = false },
    cli = {
      watch = true,
      mux = {
        backend = 'tmux',
        enabled = true,
        create = 'window',
      },
    },
  },
  keys = {
    {
      '=',
      function()
        local Nes = require 'sidekick.nes'
        if Nes.have() then
          Nes.jump()
          Nes.apply()
        end
      end,
      desc = 'Goto/Apply Next Edit Suggestion',
    },
    {
      '<leader>a',
      function()
        require('sidekick.cli').send { msg = '{file}' }
        vim.fn.system { 'tmux', 'select-window', '-t', ':2' }
      end,
      mode = { 'n' },
      desc = 'Send File',
    },
    {
      '<leader>a',
      function()
        -- Exit visual mode first to prevent newline insertion
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
        -- Small delay to ensure we've exited visual mode
        vim.defer_fn(function()
          require('sidekick.cli').send { msg = '{this}' }
          vim.fn.system { 'tmux', 'select-window', '-t', ':2' }
        end, 10)
      end,
      mode = { 'v' },
      desc = 'Send Visual Selection',
    },
    -- {
    --   '<c-.>',
    --   function()
    --     require('sidekick.cli').focus()
    --   end,
    --   mode = { 'n', 'x', 'i', 't' },
    --   desc = ('Sidekick Switch Focus',
    -- },
    -- {
    --   '<leader>aa',
    --   function()
    --     require('sidekick.cli').toggle()
    --   end,
    --   desc = 'Sidekick Toggle CLI',
    --   mode = { 'n', 'v' },
    -- },
    -- {
    --   '<leader>as',
    --   function()
    --     require('sidekick.cli').select()
    --     -- Or to select only installed tools:
    --     -- require("sidekick.cli").select({ filter = { installed = true } })
    --   end,
    --   desc = 'Sidekick Select CLI',
    --   mode = { 'n', 'v' },
    -- },
    -- {
    --   '<leader>ag',
    --   function()
    --     require('sidekick.cli').toggle { name = 'gemini', focus = true }
    --   end,
    --   desc = 'Sidekick Grok Toggle',
    --   mode = { 'n', 'v' },
    -- },
    -- {
    --   '<leader>ap',
    --   function()
    --     require('sidekick.cli').prompt()
    --   end,
    --   desc = 'Sidekick Ask Prompt',
    --   mode = { 'n', 'v' },
    -- },
  },
}
