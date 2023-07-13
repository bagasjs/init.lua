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
- <C-s> [n, i, v] -> Quickly change from any mode to visual mode
- <C-s>l [n, i, v] -> Quickly change from any mode to visual line mode
- <C-s>a [n, i, v] -> Quickly change from any mode to visual mode. This remaps <C-v> in normal mode
- <C-q> [n, i] -> Close neovim in normal mode, and go to normal mode in insert mode
- <leader>nl -> Create a new line below
- <leader>pv -> Open neovim file explorer
- <leader>sf -> Search file using telescope
- <leader>gf -> Search git file using telescope
- <leader>sw -> Search word using telescope
- <C-Space> -> Select an option give by LSP
- <C-w>v -> Start a new vertical window
- <C-w>q -> Quit a window
