return {
  'nvim-neorg/neorg',
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = '*', -- Pin Neorg to the latest stable release
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.itero'] = {
          config = {
            iterables = { 'unordered_list%d', 'ordered_list%d', 'quote%d' },
          },
        },
        ['core.concealer'] = {
          config = {
            folds = true,
            -- folds = false,
          },
        },
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/notes',
            },
            default_workspace = 'notes',
          },
        },
      },
    }

    vim.wo.foldlevel = 99
    -- vim.wo.foldmethod = 'indent'
    vim.wo.conceallevel = 2
  end,
  keys = function()
    return {
      {
        '<',
        '<Plug>(neorg.promo.demote.nested)',
        desc = 'change folds',
      },
      {
        '>',
        '<Plug>(neorg.promo.promote.nested)',
        desc = 'change folds',
      },
      {
        '<leader>cn',
        '<Plug>(neorg.dirman.new-note)',
        desc = 'Create Neorg file',
      },
    }
  end,
}
