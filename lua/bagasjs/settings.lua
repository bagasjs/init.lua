local opt = vim.opt

-- line number
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 6

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- conviniency
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

-- others
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = false
vim.opt.incsearch = true
opt.backup = false -- creates a backup file
opt.termguicolors = false -- True color support
opt.undofile = true
