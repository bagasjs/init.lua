local config = {
    "nvim-treesitter/nvim-treesitter",
    config = function ()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "javascript", "typescript", "c", "lua", "go", "rust", "php", "cpp" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end
}

local enabled = true
if enabled then
    return config
else
    return {}
end
