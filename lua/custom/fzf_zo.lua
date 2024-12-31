local M = {}

change_dir_using_zoxide = function()
  -- calling zoxide query gives the relevant dirs ordered by their score
  -- echo and xargs are used as two arguments eg. 'dir1 dir2' normally are
  -- passed as a string, this ensures they are passed as 'dir1' 'dir2'
  require('fzf-lua').fzf_live('echo <query> | xargs zoxide query --list', {
    actions = {
      ['default'] = function(selected, opts)
        require('oil').open(selected[1])
        -- increment dir score of dir in zoxide
        vim.cmd('silent !zoxide add ' .. selected[1])
      end,
    },
  })
end

vim.keymap.set('n', '<leader>r', change_dir_using_zoxide)
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>'),

return M
