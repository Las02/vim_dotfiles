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

      ['ctrl-r'] = function(selected, opts)
        change_dir_using_fd()
      end,
    },
    prompt = 'Z| ',
  })
end

-- This function and the one above can call each other to switch between zoxide and fd
-- smart when eg. the directory is not in zoxide
change_dir_using_fd = function()
  require('fzf-lua').fzf_exec('fd --type directory', {
    cwd = '/',
    -- we need to transform the output of fd to work with oil
    fn_transform = function(x)
      x = string.sub(x, 1, -2)
      return '/' .. x
    end,
    actions = {
      ['default'] = function(selected, opts)
        require('oil').open(selected[1])
        -- increment dir score of dir in zoxide
        vim.cmd('silent !zoxide add ' .. selected[1])
      end,
      ['ctrl-r'] = function(selected, opts)
        change_dir_using_zoxide()
      end,
    },
    prompt = 'D| ',
  })
end

vim.keymap.set('n', '<leader>r', change_dir_using_zoxide)

vim.keymap.set('n', 'vn', function()
  vim.cmd 'vsp'
  require('oil').open()
end)

vim.keymap.set('n', 'vr', function()
  vim.cmd 'vsp'
  change_dir_using_zoxide()
end)

return M
