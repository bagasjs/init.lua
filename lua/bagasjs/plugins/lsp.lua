return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function ()
        local cmp_lsp = require("cmp_nvim_lsp")

        require("mason").setup()
        require("mason-lspconfig").setup {
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "clangd",
                "gopls",
                "tsserver",
                "intelephense",
                "pyright",
                "cmake",
                "emmet_ls",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
                ["lua_ls"] = (function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", },
                                }
                            }
                        }
                    }
                end),
                ["emmet_ls"] = (function()
                    local lspconfig = require("lspconfig")
                    lspconfig.emmet_ls.setup {
                        filetypes = { "astro", "css", "eruby", "html", "htmldjango",
                            "javascriptreact", "less", "pug", "sass", "scss", "svelte",
                            "typescriptreact", "vue" },
                    }
                end)
            },
            automatic_installation = false,
        }

        vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
    end
}
