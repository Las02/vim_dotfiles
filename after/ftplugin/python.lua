vim.diagnostic.config { virtual_text = false, signs = false, underline = false }
-- keys = {
--   {
--     "<enter>",
--     function()
--       local t = function(keycode)
--         return vim.api.nvim_replace_termcodes(keycode, true, false, true)
--       end
--       vim.api.nvim_feedkeys(t("<Plug>SlimeSendCell"), "n", true)
--     end,
--     desc = "Slime Send Cell",
--   },
-- },
--
send_slime = function()
  local t = function(keycode)
    return vim.api.nvim_replace_termcodes(keycode, true, false, true)
  end
  vim.api.nvim_feedkeys(t '<Plug>SlimeSendCell', 'n', true)
end

ENABLE_SLIME = false
vim.keymap.set('n', '<leader>us', function()
  if ENABLE_SLIME then
    ENABLE_SLIME = false
    vim.keymap.set('n', '<enter>', '<enter>')
  else
    ENABLE_SLIME = true
    vim.keymap.set('n', '<enter>', send_slime)
  end
end)

-- if ENABLE_SLIME then
--   vim.keymap.set('n', '<enter>', send_slime)
-- end
