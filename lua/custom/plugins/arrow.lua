return {
  'otavioschwanck/arrow.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
    -- or if using `mini.icons`
    -- { "echasnovski/mini.icons" },
  },
  opts = {
    show_icons = true,
    leader_key = 'q', -- Recommended to be a single key
    buffer_leader_key = 'm', -- Per Buffer Mappings
    index_keys = 'jkl;io123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP', -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
  },
}
