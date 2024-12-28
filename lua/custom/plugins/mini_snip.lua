return {
  "echasnovski/mini.snippets",
  version = false,
  opts = {
    mappings = {
      -- Expand snippet at cursor position. Created globally in Insert mode.
      expand = "<C-j>",

      -- Interact with default `expand.insert` session.
      -- Created for the duration of active session(s)
      jump_next = "<C-l>",
      jump_prev = "<C-h>",
      stop = "<C-c>",
    },
    -- Setting snippts manually with lua, and plugin options
    --   snippets = {
    --     { prefix = "tis", body = "This is snippet", desc = "Snip" },
    --   },
  },
  -- Options to run when plugin is loaded
  init = function()
    local gen_loader = require("mini.snippets").gen_loader
    require("mini.snippets").setup({
      snippets = {
        -- Load custom file with global snippets first (adjust for Windows)
        gen_loader.from_file("~/.config/nvim/snippets/global.json"),

        -- Load snippets based on current language by reading files from
        -- "snippets/" subdirectories from 'runtimepath' directories.
        gen_loader.from_lang(),
      },
    })
  end,
}
