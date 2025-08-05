# Neovim Configuration

A modular and maintainable Neovim configuration focused on Go development, LSP integration, and productivity.

## Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── config/             # Core configuration
│   │   ├── options.lua     # Neovim options and settings
│   │   ├── keymaps.lua     # General keymappings
│   │   ├── autocmds.lua    # Auto commands and highlights
│   │   └── packer.lua      # Package manager setup
│   └── plugins/            # Plugin-specific configurations
│       ├── theme.lua       # OneDark theme configuration
│       ├── lsp.lua         # LSP and mason configuration
│       ├── telescope.lua   # Fuzzy finder configuration
│       ├── treesitter.lua  # Syntax highlighting configuration
│       ├── completion.lua  # nvim-cmp configuration
│       ├── ui.lua          # Statusline and UI plugins
│       └── copilot.lua     # GitHub Copilot configuration
└── README.md               # This file
```

## Features

### Core Features
- **Leader Key**: `<Space>`
- **Package Manager**: Packer.nvim
- **Theme**: OneDark with custom colors
- **File Explorer**: NERDTree
- **Fuzzy Finder**: Telescope with fzf integration

### Language Support
- **Go**: Full LSP support with gopls, formatting with vim-gofmt
- **Lua**: Enhanced LSP with neodev for Neovim development
- **Treesitter**: Syntax highlighting for multiple languages

### LSP Features
- **Go to Definition**: `gd`
- **Find References**: `gr` (Telescope interface)
- **Code Actions**: `<leader>ca`
- **Rename**: `<leader>rn`
- **Hover Documentation**: `K`
- **Format**: `:Format` command

### Telescope Keybindings
- **Find Files**: `<leader>sf`
- **Live Grep**: `<leader>sg`
- **Find Buffers**: `<leader><space>`
- **Help Tags**: `<leader>sh`
- **Diagnostics**: `<leader>sd`

### Git Integration
- **Git Blame**: f-person/git-blame.nvim
- **Git Signs**: lewis6991/gitsigns.nvim
- **Fugitive**: tpope/vim-fugitive

### AI Assistance
- **GitHub Copilot**: Accept suggestions with `<Alt-l>`

## Key Bindings

| Mode | Key | Action |
|------|-----|--------|
| Normal | `<leader>w` | Save file |
| Normal | `<leader>fm` | Format Go file |
| Normal | `<leader>tf` | Find in NERDTree |
| Normal | `<leader>li` | LSP Info |
| Normal | `<leader>lr` | LSP Restart |
| Normal | `[d` / `]d` | Previous/Next diagnostic |
| Normal | `<leader>e` | Open diagnostic float |
| Insert | `<Alt-l>` | Accept Copilot suggestion |

## Customization

Each module can be customized independently:

1. **Options**: Edit `lua/config/options.lua` for Neovim settings
2. **Keymaps**: Edit `lua/config/keymaps.lua` for general keymappings
3. **LSP**: Edit `lua/plugins/lsp.lua` to add/remove language servers
4. **Plugins**: Edit `lua/config/packer.lua` to add/remove plugins
5. **Theme**: Edit `lua/plugins/theme.lua` for color customizations

## Installation

The configuration will automatically install Packer and sync plugins on first run. Simply:

1. Backup your existing config
2. Place these files in `~/.config/nvim/`
3. Start Neovim
4. Wait for plugins to install
5. Restart Neovim

## Dependencies

- **Go**: Required for Go development features
- **gopls**: Go language server (auto-installed via Mason)
- **make**: Required for telescope-fzf-native
- **git**: Required for package management

## Troubleshooting

- **LSP not working**: Use `<leader>li` to check LSP status
- **Go formatting issues**: Ensure gopls is installed and Go is in PATH
- **Plugin issues**: Run `:PackerSync` to update plugins
- **Performance**: Check `:checkhealth` for optimization suggestions
