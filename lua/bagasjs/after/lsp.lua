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
    },
    automatic_installation = false,
}

local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.clangd.setup {}
lspconfig.gopls.setup {}
lspconfig.tsserver.setup {}
lspconfig.intelephense.setup {}
lspconfig.pyright.setup {}
