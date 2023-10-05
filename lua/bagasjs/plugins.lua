return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function ()
            vim.cmd [[colorscheme tokyonight]]
        end
    },
    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = (function()
            require("bagasjs.after.telescope")
        end)
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        config = (function()
            require("bagasjs.after.treesitter")
        end)
    },

    -- Autocompletion
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    {
        'hrsh7th/nvim-cmp',
        config = (function()
            require("bagasjs.after.cmp")
        end)
    },

    -- LSP
    {
        "williamboman/mason.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
        },
        config = (function()
            require("bagasjs.after.lsp")
        end)
    },
}
