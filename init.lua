-- ######################################################################
-- Installing Plugin Manager (lazy.nvim)
-- ######################################################################

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ######################################################################
-- Settings
-- ######################################################################

vim.o.whichwrap = "[]<>" -- automatically go to next line after the end of current line and vice versa
vim.o.scrolloff = 8 -- to make sure there's 8 lines before or after when scrolling
vim.o.termguicolors = true
vim.o.clipboard = 'unnamedplus' -- sync clipboard between os and neovim

-- setting map leader
vim.g.mapleader = " "
vim.g.localmapleader = " "

-- line numbering
vim.o.number = true
vim.o.numberwidth = 4
vim.o.relativenumber = true
vim.o.cursorline = true

-- indentation
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.wrap = true
vim.o.tabstop = 4
vim.o.shiftwidth = 0

-- extra configs 
vim.o.timeoutlen = 500
vim.o.updatetime = 100
vim.o.hlsearch = false

-- ######################################################################
-- Keybindings
-- ######################################################################

-- Enter visual mode faster
vim.keymap.set({'n', 'i'}, '<C-s>',  '<ESC>v', { silent = true })
vim.keymap.set({'n', 'i'}, '<C-s>l', '<ESC>V', { silent = true })
vim.keymap.set({'n', 'i'}, '<C-s>a',  '<ESC><C-v>', { silent = true })

-- Quit neovim in normal mode, go to normal mode if in insert mode
vim.keymap.set('n', '<C-q>', ':q<CR>', { silent = true })
vim.keymap.set('i', '<C-q>', '<ESC>', { silent = true })

-- Add new line on normal mode
vim.keymap.set('n', '<leader>nl', 'o<ESC>', { silent = true })

-- Enter file explorer in normal mode
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { silent = true })


-- ######################################################################
-- Plugins
-- ######################################################################

require("lazy").setup({
    {
            'navarasu/onedark.nvim',
            config = (function()
                vim.cmd.colorscheme("onedark")
            end),
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = (function()
            local telescope_builtin = require("telescope.builtin")
            vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files, {})
            vim.keymap.set('n', '<leader>gf', telescope_builtin.git_files, {})
            vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, {})
        end)
    },
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        config = (function()
            require'nvim-treesitter.configs'.setup {
                -- A list of parser names, or "all"
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "javascript", "typescript", "rust", "python", },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
            }
        end),
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        },
        config = function()
            local lsp = require("lsp-zero")
            lsp.preset("recommended")
            lsp.ensure_installed({
                'tsserver',
                'rust_analyzer',
            })
            -- Fix Undefined global 'vim'
            lsp.configure('lua-language-server', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })
            local cmp = require('cmp')
            local cmp_select = {behavior = cmp.SelectBehavior.Select}
            local cmp_mappings = lsp.defaults.cmp_mappings({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
            })
            cmp_mappings["<Tab>"] = nil
            cmp_mappings['<S-Tab>'] = nil
            lsp.setup_nvim_cmp({
                mapping = cmp_mappings
            })
            lsp.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = 'E',
                    warn = 'W',
                    hint = 'H',
                    info = 'I'
                }
            })
            lsp.on_attach(function(client, bufnr)
                local opts = {buffer = bufnr, remap = false}
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end)
            lsp.setup()
        end
    },
-- ADD EXTRA PLUGIN HERE



-- DO NOT ADD EXTRA PLUGIN BELOW SINCE THE "neo-tree" PLUGIN PART IS MESSY 
-- OR YOU CAN DELETE NEO-TREE SINCE I THINK IT'S NOT REALLY THAT IMPORTANT
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = { 
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = (function()
            -- Unless you are still migrating, remove the deprecated commands from v1.x
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

            -- If you want icons for diagnostic errors, you'll need to define them somewhere:
            vim.fn.sign_define("DiagnosticSignError",
            {text = " ", texthl = "DiagnosticSignError"})
            vim.fn.sign_define("DiagnosticSignWarn",
            {text = " ", texthl = "DiagnosticSignWarn"})
            vim.fn.sign_define("DiagnosticSignInfo",
            {text = " ", texthl = "DiagnosticSignInfo"})
            vim.fn.sign_define("DiagnosticSignHint",
            {text = "", texthl = "DiagnosticSignHint"})
            -- NOTE: this is changed from v1.x, which used the old style of highlight groups
            -- in the form "LspDiagnosticsSignWarning"

            require("neo-tree").setup({
                close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
                sort_case_insensitive = false, -- used when sorting files and directories in the tree
                sort_function = nil , -- use a custom function for sorting files and directories in the tree 
                -- sort_function = function (a,b)
                    --       if a.type == b.type then
                    --           return a.path > b.path
                    --       else
                    --           return a.type > b.type
                    --       end
                    --   end , -- this sorts files and directories descendantly
                    default_component_configs = {
                        container = {
                            enable_character_fade = true
                        },
                        indent = {
                            indent_size = 2,
                            padding = 1, -- extra padding on left hand side
                            -- indent guides
                            with_markers = true,
                            indent_marker = "│",
                            last_indent_marker = "└",
                            highlight = "NeoTreeIndentMarker",
                            -- expander config, needed for nesting files
                            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                            expander_collapsed = "",
                            expander_expanded = "",
                            expander_highlight = "NeoTreeExpander",
                        },
                        icon = {
                            folder_closed = "",
                            folder_open = "",
                            folder_empty = "ﰊ",
                            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                            -- then these will never be used.
                            default = "*",
                            highlight = "NeoTreeFileIcon"
                        },
                        modified = {
                            symbol = "[+]",
                            highlight = "NeoTreeModified",
                        },
                        name = {
                            trailing_slash = false,
                            use_git_status_colors = true,
                            highlight = "NeoTreeFileName",
                        },
                        git_status = {
                            symbols = {
                                -- Change type
                                added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                                modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                                deleted   = "✖",-- this can only be used in the git_status source
                                renamed   = "",-- this can only be used in the git_status source
                                -- Status type
                                untracked = "",
                                ignored   = "",
                                unstaged  = "",
                                staged    = "",
                                conflict  = "",
                            }
                        },
                    },
                    -- A list of functions, each representing a global custom command
                    -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
                    -- see `:h neo-tree-global-custom-commands`
                    commands = {},
                    window = {
                        position = "left",
                        width = 40,
                        mapping_options = {
                            noremap = true,
                            nowait = true,
                        },
                        mappings = {
                            ["<space>"] = { 
                                "toggle_node", 
                                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
                            },
                            ["<2-LeftMouse>"] = "open",
                            ["<cr>"] = "open",
                            ["<esc>"] = "revert_preview",
                            ["P"] = { "toggle_preview", config = { use_float = true } },
                            ["l"] = "focus_preview",
                            ["S"] = "open_split",
                            ["s"] = "open_vsplit",
                            -- ["S"] = "split_with_window_picker",
                            -- ["s"] = "vsplit_with_window_picker",
                            ["t"] = "open_tabnew",
                            -- ["<cr>"] = "open_drop",
                            -- ["t"] = "open_tab_drop",
                            ["w"] = "open_with_window_picker",
                            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
                            ["C"] = "close_node",
                            -- ['C'] = 'close_all_subnodes',
                            ["z"] = "close_all_nodes",
                            --["Z"] = "expand_all_nodes",
                            ["a"] = { 
                                "add",
                                -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                                config = {
                                    show_path = "none" -- "none", "relative", "absolute"
                                }
                            },
                            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
                            ["d"] = "delete",
                            ["r"] = "rename",
                            ["y"] = "copy_to_clipboard",
                            ["x"] = "cut_to_clipboard",
                            ["p"] = "paste_from_clipboard",
                            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
                            -- ["c"] = {
                                --  "copy",
                                --  config = {
                                    --    show_path = "none" -- "none", "relative", "absolute"
                                    --  }
                                    --}
                                    ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
                                    ["q"] = "close_window",
                                    ["R"] = "refresh",
                                    ["?"] = "show_help",
                                    ["<"] = "prev_source",
                                    [">"] = "next_source",
                                }
                            },
                            nesting_rules = {},
                            filesystem = {
                                filtered_items = {
                                    visible = false, -- when true, they will just be displayed differently than normal items
                                    hide_dotfiles = true,
                                    hide_gitignored = true,
                                    hide_hidden = true, -- only works on Windows for hidden files/directories
                                    hide_by_name = {
                                        --"node_modules"
                                    },
                                    hide_by_pattern = { -- uses glob style patterns
                                    --"*.meta",
                                    --"*/src/*/tsconfig.json",
                                },
                                always_show = { -- remains visible even if other settings would normally hide it
                                --".gitignored",
                            },
                            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                            --".DS_Store",
                            --"thumbs.db"
                        },
                        never_show_by_pattern = { -- uses glob style patterns
                        --".null-ls_*",
                    },
                },
                follow_current_file = false, -- This will find and focus the file in the active buffer every
                -- time the current file is changed while the tree is open.
                group_empty_dirs = false, -- when true, empty folders will be grouped together
                hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                -- in whatever position is specified in window.position
                -- "open_current",  -- netrw disabled, opening a directory opens within the
                -- window like netrw would, regardless of window.position
                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                -- instead of relying on nvim autocmd events.
                window = {
                    mappings = {
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["H"] = "toggle_hidden",
                        ["/"] = "fuzzy_finder",
                        ["D"] = "fuzzy_finder_directory",
                        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                        -- ["D"] = "fuzzy_sorter_directory",
                        ["f"] = "filter_on_submit",
                        ["<c-x>"] = "clear_filter",
                        ["[g"] = "prev_git_modified",
                        ["]g"] = "next_git_modified",
                    },
                    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                    ["<down>"] = "move_cursor_down",
                    ["<C-n>"] = "move_cursor_down",
                    ["<up>"] = "move_cursor_up",
                    ["<C-p>"] = "move_cursor_up",
                },
            },

            commands = {} -- Add a custom command or override a global one using the same function name
        },
        buffers = {
            follow_current_file = true, -- This will find and focus the file in the active buffer every
            -- time the current file is changed while the tree is open.
            group_empty_dirs = true, -- when true, empty folders will be grouped together
            show_unloaded = true,
            window = {
                mappings = {
                    ["bd"] = "buffer_delete",
                    ["<bs>"] = "navigate_up",
                    ["."] = "set_root",
                }
            },
        },
        git_status = {
            window = {
                position = "float",
                mappings = {
                    ["A"]  = "git_add_all",
                    ["gu"] = "git_unstage_file",
                    ["ga"] = "git_add_file",
                    ["gr"] = "git_revert_file",
                    ["gc"] = "git_commit",
                    ["gp"] = "git_push",
                    ["gg"] = "git_commit_and_push",
                }
            }
        }
    })

    vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end)
    },
}, {})

