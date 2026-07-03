return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'CodeCompanion chat' },
    { '<leader>ca', '<cmd>CodeCompanionActions<cr>', desc = 'CodeCompanion actions', mode = { 'n', 'v' } },
    { '<leader>cA', '<cmd>CodeCompanionChat Add<cr>', desc = 'Add selection to CodeCompanion chat', mode = 'v' },
    { '<leader>ci', '<cmd>CodeCompanion<cr>', desc = 'CodeCompanion inline', mode = { 'n', 'v' } },
    { '<leader>cm', '<cmd>CodeCompanionChat adapter=codex command=default<cr>', desc = 'CodeCompanion Codex chat' },
  },
  opts = {
    adapters = {
      acp = {
        codex = function()
          return require('codecompanion.adapters').extend('codex', {
            commands = {
              default = {
                'codex-acp',
              },
            },
            defaults = {
              auth_method = 'chatgpt',
              timeout = 20000,
            },
          })
        end,
      },
    },
    interactions = {
      chat = {
        adapter = 'codex',
        slash_commands = {
          buffer = {
            opts = {
              provider = 'telescope',
            },
          },
          file = {
            opts = {
              provider = 'telescope',
            },
          },
          help = {
            opts = {
              provider = 'telescope',
            },
          },
          symbols = {
            opts = {
              provider = 'telescope',
            },
          },
        },
      },
    },
    display = {
      action_palette = {
        provider = 'telescope',
      },
      chat = {
        show_settings = true,
        show_token_count = true,
        start_in_insert_mode = false,
        window = {
          layout = 'vertical',
          position = 'right',
          width = 0.45,
          opts = {
            breakindent = true,
            linebreak = true,
            wrap = true,
          },
        },
      },
    },
    opts = {
      log_level = 'INFO',
    },
  },
  config = function(_, opts)
    require('codecompanion').setup(opts)
    vim.cmd [[cabbrev cc CodeCompanion]]
  end,
}
