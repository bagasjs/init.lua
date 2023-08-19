vim.keymap.set({'i', 'v'}, '<C-c>', '<ESC><ESC>', { silent = true })

vim.keymap.set({'n', 'i', 'v'}, '<C-s>', '<CMD>w<CR><ESC>', { silent = true, desc = "Save file" })

-- Enter file explorer in normal mode
vim.keymap.set('n', '<leader>f', ':Ex<CR>', { silent = true })

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move Lines
vim.keymap.set("n", "<M-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<M-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<M-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<M-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- better indenting
vim.keymap.set("v", ">", "<gv")
vim.keymap.set("v", "<", ">gv")

-- windows
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Destoy window", remap = true })
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wh", "<C-W>s", { desc = "Split window horizontally", remap = true })
vim.keymap.set("n", "<leader>wv", "<C-W>v", { desc = "Split window vertically", remap = true })
vim.keymap.set("n", "<leader>w[", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<leader>w]", "<C-w>l", { desc = "Go to right window", remap = true })

-- tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
