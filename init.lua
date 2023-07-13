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
vim.keymap.set({'n', 'i', 'v'}, '<C-Space>',  '<ESC>v', { silent = true })
vim.keymap.set({'n', 'i', 'v'}, '<C-Space>l', '<ESC>V', { silent = true })
vim.keymap.set({'n', 'i', 'v'}, '<C-Space>a',  '<ESC><C-v>', { silent = true })

-- Quit neovim in normal mode, go to normal mode if in insert mode
vim.keymap.set('n', '<C-q>', ':q<CR>', { silent = true })
vim.keymap.set({'i', 'v'}, '<C-q>', '<ESC>', { silent = true })

vim.keymap.set({'n', 'i', 'v'}, '<C-s>', '<ESC>:w<CR>', { silent = true })

-- Add new line on normal mode
vim.keymap.set('n', '<leader>nl', 'o<ESC>', { silent = true })

-- Enter file explorer in normal mode
vim.keymap.set('n', '<leader>pv', ':Ex<CR>', { silent = true })


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
                "lua_ls",
            })
            -- Fix Undefined global 'vim'
            local cmp = require('cmp')
            local cmp_select = {behavior = cmp.SelectBehavior.Select}
            local cmp_mappings = lsp.defaults.cmp_mappings({
                ['<M-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<M-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-c>'] = cmp.mapping.complete(),
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
                vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end)
            lsp.setup()
        end
    },

-- ADD EXTRA PLUGIN HERE

}, {})

