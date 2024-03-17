return {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },

    config = function ()
        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = nil,
                ['<S-Tab>'] = nil,
            }),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            snippet = {
                expand = (function(args)
                    require("luasnip").lsp_expand(args.body)
                end)
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = (function(entry, vim_item)
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snippet]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }
        })
    end
}
