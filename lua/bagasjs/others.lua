-- Set .blade.php files to be treated as HTML
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.blade.php"},
    callback = function()
        vim.cmd("set filetype=html")
    end,
})
