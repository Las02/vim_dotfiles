return {
  "jpalardy/vim-slime",
  init = function()
    vim.g.slime_no_mappings = 1
    vim.g.slime_target = "tmux"
    vim.g.slime_bracketed_paste = 1 -- use 'interact' cmd to go to interactive
    vim.g.slime_default_config = { socket_name = "default", target_pane = "bottom" }
    vim.slime_dont_ask_default = 1
    vim.g.slime_cell_delimiter = "# %%"
  end,
  keys = {
    {
      "<enter>",
      function()
        local t = function(keycode)
          return vim.api.nvim_replace_termcodes(keycode, true, false, true)
        end
        vim.api.nvim_feedkeys(t("<Plug>SlimeSendCell"), "n", true)
      end,
      desc = "Slime Send Cell",
    },
  },
  -- nmap <leader>scc <Plug>SlimeSendCell
}
-- return {
--   {
--     "kiyoon/jupynium.nvim",
--     build = "pip3 install --user .",
--     -- build = "conda run --no-capture-output -n jupynium pip install .",
--     -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
--   },
--   "rcarriga/nvim-notify", -- optional
--   "stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
-- }
-- return {
--   "jupyter-kernel.nvim",
--   opts = {
--     inspect = {
--       -- opts for vim.lsp.util.open_floating_preview
--       window = {
--         max_width = 84,
--       },
--     },
--     -- time to wait for kernel's response in seconds
--     timeout = 0.5,
--   },
--   cmd = { "JupyterAttach", "JupyterInspect", "JupyterExecute" },
--   build = ":UpdateRemotePlugins",
--   keys = { { "<leader>k", "<Cmd>JupyterInspect<CR>", desc = "Inspect object in kernel" } },
-- }
-- return {
--   "luk400/vim-jukit",
-- }
--
-- return {
--
--   "kiyoon/jupynium.nvim",
--   build = "pip3 install --user .",
--   -- build = "conda run --no-capture-output -n jupynium pip install .",
--   -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
-- }
