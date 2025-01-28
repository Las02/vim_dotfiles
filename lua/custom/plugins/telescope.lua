return {
  'nvim-telescope/telescope.nvim',
  -- replace all Telescope keymaps with only one mapping
  keys = function()
    return {
      -- { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { '<leader>j', '<cmd>Telescope buffers<cr>', desc = 'Find Files' },
      { '<leader>o', '<cmd>Telescope oldfiles<cr>', desc = 'Find Files' },
      { '<leader>a', '<cmd>Telescope commands<cr>', desc = 'Find Files' },
      -- { '<leader>m', '<cmd>Telescope jumplist<cr>', desc = 'Find Files' },
      -- { "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find Files" },
      { '<leader>e', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'Find Files' },
      -- { "<leader>e", "<cmd>Telescope lsp_workspace_symbols query=searchTerm<cr>", desc = "Find Files" },
      -- { "<leader>gw", "<cmd>Telescope vimgrep.new<cr>", desc = "Find Files" },
      -- { '<leader>w', '<cmd>Telescope live_grep<cr>', desc = 'Find Files' },
    }
  end,
}
