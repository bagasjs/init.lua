vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(modes, key, command, config)
    vim.keymap.set(modes, key, command, config)
end

map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Move to previous buffer" })

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
map({ "n", "t" }, "<leader><tab>k", "<CMD>bd!<CR>", { desc = "Forcefully kill a buffer useful for terminal buffer" })
map("n", "<leader>pk", '<CMD>call chansend(b:terminal_job_id, "\\x03")<CR>', { desc = "Kill a process in a terminal mode" })
map("t", "<ESC>", "<C-\\><C-n>")

-- utilities
map(
    "n", "<leader><tab>r",
    (function()
        vim.cmd("tabnew")
        vim.cmd("terminal")
        local command = vim.fn.input("Command > ")
        vim.fn.chansend(vim.b.terminal_job_id, command .. "\r\n")
    end),
    { desc = "Open terminal in new tab and run the command" }
)
map("n", "<leader>rm", "<cmd>!make<cr>")
map("n", "<leader>rc", "<cmd>edit $MYVIMRC<cr>")
