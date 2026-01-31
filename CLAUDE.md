# Neovim Configuration

Based on kickstart.nvim.

## Python Development with vim-slime

The slime integration allows sending code cells to a Python REPL in a tmux pane.

### Toggle: `<leader>us`

- **ON**: Creates a tmux pane to the right, starts appropriate REPL, sets `<enter>` to send code cells
- **OFF**: Restores `<enter>` to default, closes the tmux pane

### REPL Selection (priority order)

1. `jupyter console` - if jupyter is available
2. `ipython` - if ipython is available
3. `python` - fallback

### Project Detection

**uv projects** (detected by `uv.lock` in cwd):
- Parses `pyproject.toml` to check `[project.dependencies]` for jupyter/ipython
- Runs commands with `uv run <command>`

**pip projects**:
- Checks for executables in PATH via `vim.fn.executable()`
- Runs commands directly

### Cell Delimiter

Code cells are delimited by `# %%` comments.

### Relevant Files

- `after/ftplugin/python.lua` - Python-specific slime toggle and keymaps
- `lua/custom/plugins/jupkern.lua` - vim-slime plugin configuration
