local config = {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = (function()
        require("oil").setup({
            default_file_explorer = true,
            delete_to_trash = true,
            columns = {
                "icon",
                "size",
                "permissions",
            },
            view_options = {
                show_hidden = true,
                is_hidden_file = function(name, bufnr)
                    if name == ".." then
                        return false
                    end
                    return vim.startswith(name, ".")
                end,
            },
        })

        vim.keymap.set("n", "<leader>fe", "<cmd>Oil<cr>", {})
    end)
}

local enabled = true
if enabled then
    return config
else
    return {}
end
