vim.diagnostic.config { virtual_text = false, signs = false, underline = false }

local send_slime = function()
  local t = function(keycode)
    return vim.api.nvim_replace_termcodes(keycode, true, false, true)
  end
  vim.api.nvim_feedkeys(t '<Plug>SlimeSendCell', 'n', true)
end

ENABLE_SLIME = false
SLIME_PANE_ID = nil

local function is_uv_project()
  local cwd = vim.fn.getcwd()
  return vim.fn.filereadable(cwd .. '/uv.lock') == 1
end

local function has_uv_dependency(pkg)
  local cwd = vim.fn.getcwd()
  local pyproject = cwd .. '/pyproject.toml'
  if vim.fn.filereadable(pyproject) ~= 1 then
    return false
  end
  local content = vim.fn.readfile(pyproject)
  local in_dependencies = false
  for _, line in ipairs(content) do
    if line:match('^%[project%]') or line:match('^dependencies%s*=') then
      in_dependencies = true
    elseif line:match('^%[') and not line:match('^%[project%]') then
      in_dependencies = false
    end
    if in_dependencies and line:lower():match('["\']' .. pkg .. '["\',><=~%s%]]') then
      return true
    end
  end
  return false
end

local function get_repl_cmd()
  if is_uv_project() then
    -- uv project: check pyproject.toml dependencies
    if has_uv_dependency('jupyter') then
      return 'uv run jupyter console'
    elseif has_uv_dependency('ipython') then
      return 'uv run ipython'
    else
      return 'uv run python'
    end
  else
    -- pip project: check executables in PATH
    if vim.fn.executable('jupyter') == 1 then
      return 'jupyter console'
    elseif vim.fn.executable('ipython') == 1 then
      return 'ipython'
    else
      return 'python'
    end
  end
end

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
    local repl_cmd = get_repl_cmd()
    -- Create a new pane to the right, run REPL, and capture its ID
    local pane_id = vim.fn.system('tmux split-window -h -P -F "#{pane_id}" "' .. repl_cmd .. '"'):gsub('%s+', '')
    SLIME_PANE_ID = pane_id
    -- Configure slime to target the new pane
    vim.g.slime_default_config = { socket_name = 'default', target_pane = pane_id }
    vim.b.slime_config = { socket_name = 'default', target_pane = pane_id }
    vim.keymap.set('n', '<enter>', send_slime)
    vim.notify('Slime enabled (' .. repl_cmd .. ', pane: ' .. pane_id .. ')', vim.log.levels.INFO)
  end
end)
