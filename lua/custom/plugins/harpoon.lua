return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED
    --
    vim.keymap.set('n', 'm', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    vim.keymap.set('n', '<C-h>', function()
      harpoon:list():add()
    end)

    -- require('harpoon'):list():add({ value = 'Makefile', index = 9 }, 5)
    -- vim.keymap.set('n', '<leader>1', function()
    --   harpoon:list():select(1)
    -- end)
    set_default = function()
      vim.keymap.del('n', '1')
      vim.keymap.del('n', '2')
      vim.keymap.del('n', '3')
      vim.keymap.del('n', '4')
      -- vim.keymap.set('n', 'm', function()
      --   harpoon.ui:toggle_quick_menu(harpoon:list())
      -- end)
      -- vim.keymap.del('n', 'm')
      -- vim.keymap.del('n', 'l')
      -- vim.keymap.del('n', 's')
      -- vim.keymap.set('n', 's', '<cmd> HopWord <cr>')
    end

    -- settings in menu
    harpoon:extend {
      UI_CREATE = function(cx)
        vim.keymap.set('n', '<Enter>', function()
          harpoon.ui:select_menu_item { vsplit = false }
        end, { buffer = cx.bufnr })
        -- vim.keymap.set('n', 'm', function()
        --   vim.cmd('e' .. vim.loop.cwd() .. '/Makefile')
        --   set_default()
        -- end)
        vim.keymap.set('n', 'f', function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
          harpoon:list():add()
          -- require('harpoon'):list():add { value = vim.api.nvim_buf_get_name(1), index = 'q' }
          harpoon.ui:toggle_quick_menu(harpoon:list())
          -- vim.notify('adding' ..
        end)
        vim.keymap.set('n', '1', function()
          harpoon.ui:toggle_quick_menu(harpoon:list()) -- needs to be here to avoid some wierd bug
          harpoon:list():select(1)
          set_default()
        end)
        vim.keymap.set('n', '2', function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
          harpoon:list():select(2)
          set_default()
        end)
        vim.keymap.set('n', '3', function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
          harpoon:list():select(3)
          set_default()
        end)
        vim.keymap.set('n', '4', function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
          harpoon:list():select(4)
          set_default()
        end)
        -- vim.keymap.set('n', 'm', function()
        -- harpoon.ui:toggle_quick_menu(harpoon:list())
        --   harpoon:list():select(5)
        --   set_default()
        -- end)
        -- vim.keymap.set('n', 'l', function()
        --   harpoon.ui:toggle_quick_menu(harpoon:list())
        --   -- harpoon:list():select(6)
        --   go_to_buffer_by_name 'Makefile'
        --   set_default()
        -- end)
      end,
    }

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    -- vim.keymap.set('n', ',t', function()
    --   toggle_telescope(harpoon:list())
    -- end, { desc = 'Open harpoon window' })
  end,
  -- keys = function()
  --   return {
  --     { '<leader>s', require('harpoon').list():add(), desc = 'Find Symbols' },
  --   }
  -- end,
}
