# Neovim Configuration

Personal Neovim configuration based on kickstart.nvim, tailored for Python/data science workflows.

## Architecture

- **Plugin Manager**: lazy.nvim with modular plugin specs in `lua/custom/plugins/`
- **LSP**: nvim-lspconfig + Mason for automatic server installation
- **Completion**: blink.cmp (configured in `lua/custom/plugins/newblink.lua`)
- **Formatting**: conform.nvim (ruff for Python, stylua for Lua)

## Key Files

| File | Purpose |
|------|---------|
| `init.lua` | Core configuration, lazy.nvim setup, base keymaps |
| `lua/custom/config/keymaps.lua` | Custom keybindings and helper functions |
| `lua/custom/plugins/*.lua` | Plugin specifications (lazy.nvim format) |
| `after/ftplugin/python.lua` | Python-specific REPL integration |

## Python REPL Integration (vim-slime)

Toggle with `<leader>us`. Creates a tmux pane and starts an appropriate REPL.

### Implementation Details

- **Config**: `lua/custom/plugins/jupkern.lua` - vim-slime base configuration
- **Toggle Logic**: `after/ftplugin/python.lua` - handles pane creation/destruction

### REPL Detection (`after/ftplugin/python.lua`)

```
is_uv_project()     -> checks for uv.lock in cwd
has_uv_dependency() -> parses pyproject.toml [project.dependencies]
get_repl_cmd()      -> returns appropriate command based on detection
```

**Priority**:
1. uv projects: `uv run jupyter console` or `uv run ipython`
2. Standard: `jupyter console` or `ipython` (via `vim.fn.executable()`)

### Cell Delimiter

`# %%` (configured via `vim.g.slime_cell_delimiter`)

## tmux Integration

Several features rely on tmux:

- **REPL**: Creates split pane, sends code via vim-slime
- **Makefile runner**: Sends commands to tmux window `:2`
- **DataFrame viewer**: Uses visidata in tmux window `:2`

Global state variables:
- `ENABLE_SLIME` - tracks REPL toggle state
- `SLIME_PANE_ID` - stores tmux pane ID for cleanup
- `_G.FILENAME` - stores selected Makefile target

## LSP Configuration

Servers defined in `init.lua`:
- `basedpyright` - Python (also handles snakemake)
- `lua_ls` - Lua with Neovim API support
- `rust_analyzer` - Rust
- `ts_ls` - TypeScript/JavaScript
- `sqlls` - SQL

## Navigation Plugins

| Plugin | Key | Description |
|--------|-----|-------------|
| fzf-lua | `<leader>f`, `<leader>w`, `/` | File/grep search |
| Harpoon | `m`, `<C-h>` | Quick file bookmarks |
| Oil.nvim | `<leader>n` | File explorer |
| Hop | `s` | Word jumping |

## Conventions

- Leader key: `<Space>`
- Filetype configs go in `after/ftplugin/`
- New plugins go in `lua/custom/plugins/`
- Disabled/experimental code in `lua/custom/not_used/`
