-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Harpoon

-- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
-- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
--
-- -- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
--
--
MARKS = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I' }
MARK_TO_SET = 1
vim.keymap.set('n', '<leader>am', function()
  -- print(vim.inspect(MARKS[MARK_TO_SET]))
  vim.cmd('normal! m' .. MARKS[MARK_TO_SET])
  MARK_TO_SET = 1 + MARK_TO_SET
end)

-- vim.keymap.set('n', 'gd', function()
--   vim.lsp.buf.definition()
-- end)
vim.keymap.set('n', '<leader>q', function()
  vim.api.nvim_set_current_line '# %%'
end)

-- default to now show inline hints but give options to turn of and on
vim.diagnostic.config { virtual_text = false }

vim.keymap.set('n', '<leader>ud', function()
  vim.diagnostic.config { virtual_text = false }
end, { noremap = true, silent = true, desc = 'Toggle vim diagnostics' })
vim.keymap.set('n', '<leader>ued', function()
  vim.diagnostic.config { virtual_text = true }
end, { noremap = true, silent = true, desc = 'Toggle vim diagnostics' })

-- inlay hints
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { 0 }, { 0 })

vim.keymap.set({ 'v' }, '<C-c>', '"+y', {})

local opt = vim.opt
opt.clipboard = ''
vim.keymap.set('n', '=', '}', {})

function split(pString, pPattern)
  local Table = {} -- NOTE: use {n = 0} in Lua-5.0
  local fpat = '(.-)' .. pPattern
  local last_end = 1
  local s, e, cap = pString:find(fpat, 1)
  while s do
    if s ~= 1 or cap ~= '' then
      table.insert(Table, cap)
    end
    last_end = e + 1
    s, e, cap = pString:find(fpat, last_end)
  end
  if last_end <= #pString then
    cap = pString:sub(last_end)
    table.insert(Table, cap)
  end
  return Table
end

CURRENT_DF = ''
COOL = function(cmd_, to_write, excel)
  -- Get the current line number
  local current_line = vim.api.nvim_win_get_cursor(0)[1] -- 5
  local cursor_position = vim.api.nvim_win_get_cursor(0)

  -- Get the total number of lines in the buffer
  local total_lines = vim.api.nvim_buf_line_count(0)

  local line = vim.api.nvim_get_current_line()
  char_ = ''
  found = false
  for i = 1, #line do
    local char = line:sub(i, i) -- Extract the character at position i
    if char == '=' or char == '.' or char == '[' then
      break
    end
    if char ~= '(' and char ~= ' ' then
      char_ = char_ .. char
    end
  end
  local df = char_
  found = true
  if not found then
    df = ''
  end

  if df ~= '' then
    vim.api.nvim_command 'normal! yyp'
    --
    local new_line = df .. to_write
    vim.api.nvim_set_current_line(new_line)
    vim.cmd(cmd_)

    if not excel then
      -- tmux open
      -- without auto reload
      -- local run = "silent !tmux send -t :2 'visidata " .. "tmp.csv" .. "' Enter; tmux select-window -t :2 "
      -- with auto reload
      -- local run = "silent !tmux select-window -t :2 "
      -- vim.cmd(run)
      vim.fn.system { 'tmux', 'select-window', '-t', ':2' } -- does not write message.. nice
    else
      -- Open with default
      vim.ui.open 'tmp.csv'
    end

    vim.api.nvim_command 'normal! dd'

    vim.api.nvim_win_set_cursor(0, cursor_position)
    -- -- Check if the current line is the last line
    -- if current_line ~= total_lines then
    --   vim.api.nvim_command("normal! k")
    -- end
    CURRENT_DF = df
  end
end

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

map('x', 'p', 'P')

-- before JupyterSendCount
vim.keymap.set('n', '<leader>1h', function()
  COOL('SlimeSend', ".head(30).to_csv('tmp.csv', index=False)", false)
end, {})
vim.keymap.set('n', '<leader>1d', function() -- show head
  COOL('SlimeSend', ".to_csv('tmp.csv', index=False)", false)
end, {})
--
--
-- Right now cannot send cell which is equal to seeing the state of the
-- df at a point
-- vim.keymap.set("n", "<leader>sch", function() -- show cell head
--   COOL("SlimeSend", ".head(30).to_csv('tmp.csv', index=False)", false)
-- end, {})
-- vim.keymap.set("n", "<leader>scd", function()
--   COOL("SlimeSend", ".to_csv('tmp.csv', index=False)", false)
-- end, {})
vim.keymap.set('n', '<leader>1xd', function() -- show excel dataframe
  COOL('SlimeSend', ".to_csv('tmp.csv', index=False)", true)
end, {})
vim.keymap.set('n', '<leader>1xh', function() -- show excel head
  COOL('SlimeSend', ".head(30).to_csv('tmp.csv', index=False)", true)
end, {})
-- vim.keymap.set("n", "<leader>sr", function() -- reload
--   vim.cmd("JupyterSendCell")
--   local cursor_position = vim.api.nvim_win_get_cursor(0)
--   vim.api.nvim_command("normal! yyp")
--   --
--   local new_line = CURRENT_DF .. ".to_csv('tmp.csv', index=False)"
--   vim.api.nvim_set_current_line(new_line)
--
--   vim.cmd("SlimeSend")
--   vim.api.nvim_command("normal! dd")
--
--   vim.api.nvim_win_set_cursor(0, cursor_position)
--   -- local run = "silent !tmux send -t :2 'visidata " .. "tmp.csv" .. "' Enter; tmux select-window -t :2 "
--   -- with auto reload
--   vim.fn.system({ "tmux", "select-window", "-t", ":2" }) -- does not write message.. nice
-- end, {})

-- vim.keymap.set("n", "<leader>1", function()
--   COOL("JupyterSendCell")
-- end, {})
-- COOL2 = function()
--   local line = vim.api.nvim_get_current_line()
--   local pattern = "^%s*(.-)%s*[.=]"
--   -- local pattern = "^%s*(.-)%s*[%[%]=%w%(]"
--   local df = line:match(pattern)
--   vim.api.nvim_command("normal! yyp")
--
--   local new_line = df .. ".to_csv('tmp.csv', index=False)"
--   vim.api.nvim_set_current_line(new_line)
--   vim.cmd("JupyterSendCell")
--   vim.ui.open("tmp.csv")
--   vim.api.nvim_command("normal! dd")
--   vim.api.nvim_command("normal! k")
-- end

-- vim.keymap.set('n', '<tab>', '<C-^>', {})
vim.keymap.set('n', '<M-d>', '<C-d>M', {})
vim.keymap.set('n', '<M-u>', '<C-u>M', {})
vim.keymap.set('n', '<M-o>', '<C-o>', {})
vim.keymap.set('n', '<M-i>', '<C-i>', {})

vim.keymap.set('n', '<leader><space>', function()
  vim.cmd 'JupyterSendCell'
end, {})
-- vim.keymap.set("n", "<enter>", function()
--   vim.cmd("JupyterSendCell")
-- end, {})
-- vim.keymap.set("n", "<C-CR>", function()
--   vim.cmd("JupyterSendCell")
-- end, {})
-- vim.keymap.set("n", "<C-CR>", function()
--   vim.cmd("JupyterSendCell")
-- end, {})
-- keys = { { "<leader><space>", "<Cmd>JupyterSendCell<CR>", desc = "Inspect object in kernel" } },
-- require("jupynium").setup({
--   --- For Conda environment named "jupynium",
--   -- python_host = { "conda", "run", "--no-capture-output", "-n", "jupynium", "python" },
--   python_host = vim.g.python3_host_prog or "/home/las/ubuntu2/miniconda3/bin/python3",
--
--   -- default_notebook_URL = "localhost:8888/nbclassic",
--   -- firefox_profiles_ini_path = "/usr/bin/firefox",
--
--   -- Write jupyter command but without "notebook"
--   -- When you call :JupyniumStartAndAttachToServer and no notebook is open,
--   -- then Jupynium will open the server for you using this command. (only when notebook_URL is localhost)
--   -- jupyter_command = "jupyter",
--   --- For Conda, maybe use base environment
--   --- then you can `conda install -n base nb_conda_kernels` to switch environment in Jupyter Notebook
--   jupyter_command = { "conda", "run", "--no-capture-output", "-n", "base", "jupyter" },
-- })

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = 'basedpyright'
-- vim.keymap.set("n", "<leader>n", "<cmd> Ex <cr>", {})
-- vim.keymap.set("n", "<leader>k", "<cmd> make <cr>", {})
-- vim.keymap.set("n", "<leader>k", "<cmd> silent !tmux send -t :2 'make ' Enter; tmux select-window -t :2 <cr>", {})
-- vim.keymap.set("n", "<leader>k", "<cmd> silent !tmux send -t 2 'make ' Enter <cr>", {})
-- vim.keymap.set("n", "<leader>k", "<cmd> silent !tmux send -t 2 'make ' Enter; tmux resize-pane -Z <cr>", {})
-- :2 is pane TWO, 2 is just the second one

-- local start = "<cmd>silent !tmux send -t :2 '"
-- local sick_cmd = 'cat Makefile | grep ":" | sed "s/://" | head -n1 | tr -d "\\n" | tr -d " " | xargs -I {} make {}'
-- local _end = "' Enter; tmux select-window -t :2'<CR>"
--
--
--Function choose make file based on file
-- local tst = "cat Makefile | grep ':' | sed 's/://' | fzf | " .. 'tr -d " "' .. "| xargs -I {} make {}"
-- vim.keymap.set(
--   "n",
--   "<leader>l",
--   "<cmd> silent !tmux send -t :2 '" .. tst .. "' Enter ;tmux select-window -t :2 <CR>",
--   {}
-- )

-- Initial element if has not been ran before
_G.FILENAME = 'all'
vim.keymap.set('n', '<leader>l', function()
  -- The following runs telescope with a command and saves the output
  local filepath = debug.getinfo(1).source:match '@?(.*/)'
  local opts = {
    -- this is the command which gives the elements to choose from
    find_command = { 'bash', filepath .. 'get_options_from_Makefile.sh' },

    -- This one saves the picked element to _G.FILENAME
    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        -- filename is available at entry[1]
        local entry = require('telescope.actions.state').get_selected_entry()
        require('telescope.actions').close(prompt_bufnr)
        _G.FILENAME = entry[1]
      end)
      return true
    end,

    -- and what to show
    previewer = require('telescope.previewers').new_termopen_previewer {
      get_command = function(entry)
        local hash = entry.value
        filepath = debug.getinfo(1).source:match '@?(.*/)'
        return { 'python3', filepath .. 'get_correct.py', hash }
      end,
    },
  }
  require('telescope.builtin').find_files(opts)
end, {})

-- needs extra function to take arguments
local RunMakeWithTheChoosenName = function(_G)
  print(_G.FILENAME)

  vim.cmd 'w'
  -- local cwd = vim.loop.cwd()
  local cmd = "silent !tmux send -t :2 'make "
    .. _G.FILENAME
    -- .. " &| tee .err; "
    -- .. "cat .err | grep " -- START remove this to just use normal compiler and not format it before
    -- .. cwd
    -- .. " | tac > .err.reversed; " -- ENd
    .. "' Enter; tmux select-window -t :2 "
  vim.cmd(cmd)
end
vim.keymap.set(
  'n',
  '<leader>k',
  function()
    RunMakeWithTheChoosenName(_G)
  end,
  -- "<cmd> !tmux send -t :2 'make " .. _G.FILENAME .. "' Enter; tmux select-window -t :2 <cr>",
  { silent = true }
)

vim.keymap.set('n', 'ge', function()
  -- vim.cmd("compiler pyunit")
  -- vim.cmd("cf .err.reversed") -- cg does not jump to first error. Set to just .err for other than python
  vim.cmd 'cg .err.reversed' -- cg does not jump to first error. Set to just .err for other than python
  vim.cmd 'Telescope quickfix'

  -- vim.cmd("cf .err.reversed") -- cg does not jump to first error
end, {})
-- vim.keymap.set("n", "gj", function()
--   vim.cmd("setl efm=%A%f:%l: %m,%-Z%p^,%-C%.%#") -- java
--   vim.cmd("cf .err") -- cg does not jump to first error
-- end, {})

-- print(start .. sick_cmd .. _end)
--
-- end, {})

-- vim.keymap.set('n', 's', '<cmd> HopWord <cr>', { remap = true })
-- vim.keymap.set('v', 's', '<cmd> HopWord <cr>', { remap = true })
-- vim.keymap.set('o', 's', '<cmd> HopWord <cr>', { remap = true })

vim.api.nvim_set_option('clipboard', '')
vim.keymap.set('v', '<C-c>', '"+yi', {})

-- Oil
vim.keymap.set('n', '<leader>n', '<cmd> Oil <cr>', {})
vim.keymap.set('n', '<leader>d', '<cmd> bd <cr>', {})
-- vim.keymap.set("v", "y", '"+yi', {})
-- vim.keymap.set("n", "y", '"+yi', {})
-- vim.keymap.set("v", "y", '"+yi', {})
--
-- vim.keymap.set("n", "<leader>q", "<cmd> bd <cr>", {})

vim.keymap.set('n', '=', '}', {})
vim.keymap.set('v', '=', '}', {})
vim.keymap.set('o', '=', '}', {})
--
-- vim.keymap.set("n", "[e", "<cmd>cn<cr>", {})
-- vim.keymap.set("n", "]e", "<cmd>cp<cr>", {})
-- Remove some lazy vim default keymaps
vim.cmd 'source /home/las/.config/nvim/lua/custom/config/vimi.vim'
