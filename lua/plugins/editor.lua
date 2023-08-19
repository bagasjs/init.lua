return {
---- Fuzzy Finder
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { "<leader>f", "<CMD>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ winblend = 10 }))<CR>", desc = "Find files" },
            { "<leader>/", "<CMD>Telescope live_grep theme=dropdown<CR>", desc = "Live grep" },
            { "<leader><space>", "<cmd>Telescope find_files theme=dropdown<CR>", desc = "Find files" },

            { "<leader>sM", "<CMD>Telescope man_pages<CR>", desc = "Manual Pages" },
        },
        opts = function ()
            return {
                extensions = {
                    file_browser = {
                        theme = "dropdown",
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {
                            ["i"] = {
                                -- your custom insert mode mappings
                            },
                            ["n"] = {
                                -- your custom normal mode mappings
                            },
                        },
                    },
                },
            }
        end,
        config = function (_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("file_browser")
        end
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }
---- Which Key
--     {
--         "folke/which-key.nvim",
--         event = "VeryLazy",
--         opts = {
--             plugins = { spelling = true },
--             defaults = {
--                 mode = { "n", "v" },
--                 ["g"] = { name = "+goto" },
--                 ["gz"] = { name = "+surround" },
--                 ["]"] = { name = "+next" },
--                 ["["] = { name = "+prev" },
--                 ["<leader><tab>"] = { name = "+tabs" },
--                 ["<leader>b"] = { name = "+buffer" },
--                 ["<leader>c"] = { name = "+code" },
--                 ["<leader>f"] = { name = "+file/find" },
--                 ["<leader>g"] = { name = "+git" },
--                 ["<leader>gh"] = { name = "+hunks" },
--                 ["<leader>q"] = { name = "+quit/session" },
--                 ["<leader>s"] = { name = "+search" },
--                 ["<leader>u"] = { name = "+ui" },
--                 ["<leader>w"] = { name = "+windows" },
--                 ["<leader>x"] = { name = "+diagnostics/quickfix" },
--             },
--         },
--         config = function(_, opts)
--             local wk = require("which-key")
--             wk.setup(opts)
--             wk.register(opts.defaults)
--         end,
--     },
}
