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
    -- { -- '<S-tab>', '=', function() local Nes = require 'sidekick.nes' if Nes.have() then Nes.jump() Nes.apply() end -- if there is a next edit, jump to it, otherwise apply it if any if not require('sidekick').nes_jump_or_apply() then return '<Tab>' -- fallback to normal tab end end, expr = true, desc = 'Goto/Apply Next Edit Suggestion', },
    {
      '<leader>a',
      function()
        require('sidekick.cli').send { msg = '{file}' }
        vim.fn.system { 'tmux', 'select-window', '-t', ':2' } -- does not write message.. nice
      end,
      mode = { 'n' },
      desc = 'Send File',
    },
    {
      '<leader>a',
      function()
        require('sidekick.cli').send { msg = '{this}' }
        vim.fn.system { 'tmux', 'select-window', '-t', ':2' } -- does not write message.. nice
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
