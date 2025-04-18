local config = {
    "nvim-telescope/telescope.nvim", tag = "0.1.3",
    config = function ()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
        vim.keymap.set("n", "<leader><space>", builtin.find_files, {})
        vim.keymap.set("n", "<leader>ps", (function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end), {})
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    end
}

local enabled = true
if enabled then
    return config
else
    return {}
end
