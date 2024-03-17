vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(modes, key, command, config)
    vim.keymap.set(modes, key, command, config)
end

map("n", "<leader>fe", "<cmd>Explore<cr>", { silent = true })
map({ "n", "i", "v", "x", "t" }, "<C-c>", "<esc><esc><esc>", { silent = true })
map('n', '-', '$')
map("n", "J", "mzJ`z")

-- move Lines
map("n", "<M-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<M-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<M-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<M-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- better indenting
map({"v", "x"}, "<", "<gv")
map({"v", "x"}, ">", ">gv")

-- tabs
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>t", "<CMD>tabnew<CR><CMD>terminal<CR>", { desc = "Open Terminal in new Tab" })
map("t", "<ESC>", "<C-\\><C-n>")
