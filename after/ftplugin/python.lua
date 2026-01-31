vim.diagnostic.config { virtual_text = false, signs = false, underline = false }

local send_slime = function()
  local t = function(keycode)
    return vim.api.nvim_replace_termcodes(keycode, true, false, true)
  end
  vim.api.nvim_feedkeys(t '<Plug>SlimeSendCell', 'n', true)
end

ENABLE_SLIME = false
SLIME_PANE_ID = nil

vim.keymap.set('n', '<leader>us', function()
  if ENABLE_SLIME then
    -- Toggle OFF: restore keymap and close pane
    ENABLE_SLIME = false
    vim.keymap.set('n', '<enter>', '<enter>')
    if SLIME_PANE_ID then
      vim.fn.system('tmux kill-pane -t ' .. SLIME_PANE_ID)
      SLIME_PANE_ID = nil
    end
    vim.notify('Slime disabled', vim.log.levels.INFO)
  else
    -- Toggle ON: create pane to the right and set keymap
    ENABLE_SLIME = true
    -- Create a new pane to the right and capture its ID
    local pane_id = vim.fn.system('tmux split-window -h -P -F "#{pane_id}"'):gsub('%s+', '')
    SLIME_PANE_ID = pane_id
    -- Configure slime to target the new pane
    vim.g.slime_default_config = { socket_name = 'default', target_pane = pane_id }
    vim.b.slime_config = { socket_name = 'default', target_pane = pane_id }
    vim.keymap.set('n', '<enter>', send_slime)
    vim.notify('Slime enabled (pane: ' .. pane_id .. ')', vim.log.levels.INFO)
  end
end)
