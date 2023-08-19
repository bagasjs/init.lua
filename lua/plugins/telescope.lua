return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { "<leader>fe", "<CMD>Telescope file_browser<CR>", desc = "File browser" },
            { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find files" },
            { "<leader>fs", "<CMD>Telescope live_grep<CR>", desc = "Live grep" },
            { "<leader><space>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
            { "<leader>fm", "<CMD>Telescope man_pages<CR>", desc = "Manual Pages" },
        },
        opts = function ()
            local fb_actions = require("telescope").extensions.file_browser.actions
            return {
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "-L",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    initial_mode = "insert",
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    layout_strategy = "vertical",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    file_ignore_patterns = { "node_modules" },
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    path_display = { "truncate" },
                    winblend = 0,
                    border = {},
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    color_devicons = true,
                    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    -- Developer configurations: Not meant for general override
                    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                    mappings = {
                        n = { ["q"] = require("telescope.actions").close },
                    },
                },
                pickers = {
                },
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                        initial_mode = "normal",
                        mappings = {
                            ["n"] = {
                                ["n"] = fb_actions.create,
                                ["d"] = fb_actions.remove,
                                ["r"] = fb_actions.rename,
                                ["m"] = fb_actions.move,
                            },
                        }
                    }
                },
            }
        end,
        config = function (_, opts)
            local telescope = require("telescope");
            telescope.setup(opts)
            telescope.load_extension("file_browser");
        end,
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
}
