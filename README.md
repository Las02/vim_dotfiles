# Neovim Configuration

A personal Neovim configuration built on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), optimized for Python development and data science workflows.

## Features

- **LSP Support**: basedpyright, lua_ls, rust_analyzer, ts_ls, sqlls with Mason for automatic installation
- **Fuzzy Finding**: fzf-lua and Telescope for files, grep, symbols, and marks
- **File Navigation**: Harpoon for quick file switching, Oil.nvim for file exploration
- **Git Integration**: Gitsigns, LazyGit, and Diffview
- **Code Formatting**: Conform.nvim with ruff (Python) and stylua (Lua)
- **Completion**: blink.cmp with LSP and Copilot integration
- **Syntax**: Treesitter with auto-install
- **UI**: Tokyonight theme, which-key, mini.statusline

## Requirements

- Neovim >= 0.9.0
- Git
- A C compiler (for Treesitter)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for live grep)
- [fzf](https://github.com/junegunn/fzf)
- [tmux](https://github.com/tmux/tmux) (for REPL integration)

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this repository
git clone <repo-url> ~/.config/nvim

# Start Neovim (plugins install automatically)
nvim
```

## Key Bindings

Leader key: `<Space>`

### Navigation

| Key | Description |
|-----|-------------|
| `<leader>f` | Find files |
| `<leader>w` | Live grep |
| `/` | Grep current buffer |
| `<leader><leader>` | Find buffers |
| `<leader>m` | Browse marks |
| `m` | Harpoon menu |
| `<C-h>` | Add to Harpoon |
| `<Tab>` | Alternate buffer |
| `s` | Hop word |

### LSP

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gn` | Rename symbol |
| `gI` | Go to implementation |
| `<leader>ca` | Code action |
| `<leader>D` | Type definition |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |
| `<C-s>` (insert) | Signature help |

### File Management

| Key | Description |
|-----|-------------|
| `<leader>n` | Open Oil file explorer |
| `<leader>d` | Close buffer |
| `<leader>gg` | Open LazyGit |

### Diagnostics

| Key | Description |
|-----|-------------|
| `<leader>ud` | Hide virtual text diagnostics |
| `<leader>ued` | Show virtual text diagnostics |
| `<leader>th` | Toggle inlay hints |
| `<leader>q` | Open diagnostic quickfix |

## Python REPL Integration

This configuration includes vim-slime integration for sending code to a Python REPL running in tmux.

### Toggle: `<leader>us`

- **ON**: Creates a tmux pane, starts the appropriate REPL, maps `<Enter>` to send code cells
- **OFF**: Restores `<Enter>` to default, closes the tmux pane

### REPL Selection

The REPL is selected based on project type and available tools:

**uv projects** (detected by `uv.lock`):
1. `uv run jupyter console` - if jupyter is in dependencies
2. `uv run ipython` - fallback

**Standard projects**:
1. `jupyter console` - if available in PATH
2. `ipython` - fallback

### Cell Delimiter

Code cells are delimited by `# %%` comments (VS Code/Jupyter style).

### DataFrame Inspection

| Key | Description |
|-----|-------------|
| `<leader>1h` | Send DataFrame head to visidata |
| `<leader>1d` | Send full DataFrame to visidata |
| `<leader>1xh` | Open DataFrame head in Excel |
| `<leader>1xd` | Open full DataFrame in Excel |

Requires [visidata](https://www.visidata.org/) running in tmux window 2.

## Makefile Integration

| Key | Description |
|-----|-------------|
| `<leader>l` | Select Makefile target with preview |
| `<leader>k` | Run selected Makefile target |
| `ge` | Open errors in quickfix (from `.err.reversed`) |

Requires tmux with window 2 available for command execution.

## Project Structure

```
~/.config/nvim/
├── init.lua                 # Main configuration
├── after/ftplugin/          # Filetype-specific settings
│   └── python.lua           # Python REPL toggle
├── lua/
│   ├── kickstart/           # Kickstart modules
│   │   └── plugins/         # Kickstart plugin configs
│   └── custom/
│       ├── config/
│       │   └── keymaps.lua  # Custom keybindings
│       └── plugins/         # Custom plugin specs
│           ├── fzf.lua
│           ├── harpoon.lua
│           ├── hop.lua
│           ├── jupkern.lua  # vim-slime config
│           ├── lazygit.lua
│           ├── oil.lua
│           └── ...
```

## License

MIT
