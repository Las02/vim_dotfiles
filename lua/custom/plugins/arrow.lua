return {
  'otavioschwanck/arrow.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
    -- or if using `mini.icons`
    -- { "echasnovski/mini.icons" },
  },
  opts = {
    show_icons = true,
    mappings = {
      delete_mode = 'r',
      next_item = 'a',
      prev_item = 'd',
      toggle = 'f',
      quit = 'x',
    },
    custom_actions = {
      open = function(target_file_name, current_file_name)
        vim.notify 'hello'
      end,
    },
    leader_key = '<leader>,', -- Recommended to be a single key
    -- leader_key = ',', -- Recommended to be a single key
    buffer_leader_key = ',', -- Per Buffer Mappings
    index_keys = '123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP', -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
    -- index_keys = '123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP', -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
    per_buffer_config = {
      lines = 3, -- Number of lines showed on preview.
      -- sort_automatically = false,
    },
  },
}
