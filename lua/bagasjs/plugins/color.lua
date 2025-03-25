local config = {
    "folke/tokyonight.nvim",
    {
        "rose-pine/neovim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = (function()
            vim.cmd [[colorscheme rose-pine]]
        end)
    }
}

local enabled = false
if enabled then
    return config
else
    return {}
end
