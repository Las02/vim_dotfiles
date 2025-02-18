return {
  -- https://www.reddit.com/r/neovim/comments/1ij8xjl/symbols_navigator_with_real_preview_fully/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button alternative ? faster?
  'bassamsdata/namu.nvim',
  config = function()
    require('namu').setup {
      -- Enable the modules you want
      namu_symbols = {
        enable = true,
        options = {}, -- here you can configure namu
      },
      -- Optional: Enable other modules if needed
      ui_select = { enable = false }, -- vim.ui.select() wrapper
      colorscheme = {
        enable = false,
        options = {
          -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
          persist = true, -- very efficient mechanism to Remember selected colorscheme
          write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
        },
      },
    }
    -- === Suggested Keymaps: ===
    vim.keymap.set('n', '<leader>s', ':Namu symbols<cr>', {
      desc = 'Jump to LSP symbol',
      silent = true,
    })
    vim.keymap.set('n', '<leader>th', ':Namu colorscheme<cr>', {
      desc = 'Colorscheme Picker',
      silent = true,
    })
  end,
}
