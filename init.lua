-- ######################################################################
-- Installing Plugin Manager (lazy.nvim)
-- ######################################################################

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ######################################################################
-- Settings
-- ######################################################################

vim.o.whichwrap = "[]<>" -- automatically go to next line after the end of current line and vice versa
vim.o.scrolloff = 8 -- to make sure there's 8 lines before or after when scrolling
vim.o.termguicolors = true

-- setting map leader
vim.g.mapleader = " "
vim.g.localmapleader = " "

-- line numbering
vim.o.number = true
vim.o.numberwidth = 4
vim.o.relativenumber = true
vim.o.cursorline = true

-- indentation
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.wrap = true
vim.o.tabstop = 4
vim.o.shiftwidth = 0

-- extra configs 
vim.o.timeoutlen = 500
vim.o.updatetime = 100
vim.o.hlsearch = false

-- ######################################################################
-- Keybindings
-- ######################################################################

-- Enter visual mode faster
vim.keymap.set('n', '<C-Space>',  '<ESC>v', { silent = true })
vim.keymap.set('i', '<C-Space>',  '<ESC>v', { silent = true })
vim.keymap.set('n', '<C-Space>l', '<ESC>V', { silent = true })
vim.keymap.set('i', '<C-Space>l', '<ESC>V', { silent = true })
vim.keymap.set('n', '<C-Space>a',  '<ESC><C-v>', { silent = true })
vim.keymap.set('i', '<C-Space>a',  '<ESC><C-v>', { silent = true })

-- Quit neovim in normal mode, go to normal mode if in insert mode
vim.keymap.set('n', '<C-q>', ':q<CR>', { silent = true })
vim.keymap.set('i', '<C-q>', '<ESC>', { silent = true })

-- Add new line on normal mode
vim.keymap.set('n', '<leader>nl', 'o<ESC>', { silent = true })

-- Enter file explorer in normal mode
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { silent = true })


-- ######################################################################
-- Plugins
-- ######################################################################

require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = { 
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    },
}, {})
