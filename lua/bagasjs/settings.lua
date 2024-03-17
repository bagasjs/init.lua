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
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.backup = false -- creates a backup file
vim.opt.termguicolors = false -- True color support
vim.opt.undofile = true

-- Netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
