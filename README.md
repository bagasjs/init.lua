# My Neovim Config

## Used plugins
- nvim-telescope/telescope.nvim
- nvim-treesitter
- VonHeikemen/lsp-zero.nvim
- navarasu/onedark.nvim
- nvim-neo-tree/neo-tree.nvim

## Useful settings
- mapleader : <Space>
- localmapleader : <Space>
- clipboard : unnamed // the OS clipboard and neovim clipboard are sync

## Useful keybindings
PATTERN: Keys [Modes] -> Description
- <C-Space> [n, i, v] -> Quickly change from any mode to visual mode
- <C-Space>l [n, i, v] -> Quickly change from any mode to visual line mode
- <C-Space>a [n, i, v] -> Quickly change from any mode to visual mode. This remaps <C-v> in normal mode
- <C-q> [n, i, v] -> Close neovim in normal mode, and go to normal mode in insert and visual mode
- <leader>nl [n] -> Create a new line below
- <leader>pv [n] -> Open neovim file explorer
- <leader>rf [n] -> Get the reference of a keyword
- <leader>sf [n] -> Search file using telescope
- <leader>gf [n] -> Search git file using telescope
- <leader>sw [n]-> Search word using telescope
- <CR> [i]-> Select an option give by LSP
- <C-c> [i] -> Trigger LSP completion
- <C-w> [n]-> Start a new vertical window
- <C-w>q [n] -> Quit a window
