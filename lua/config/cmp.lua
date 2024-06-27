return function()
    local cmp = require("cmp")
    local snip = require("luasnip")
    local lspkind = require('lspkind')
    snip.config.setup {}
    cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },

        formatting = {
            format = lspkind.cmp_format({
                mode = 'symbol',
                maxwidth = 50,
                ellipsis_char = '...',
                show_labelDetails = true,
                before = function(_, vim_item)
                    return vim_item
                end
            })
        },

        sources = {
            { name = "nvim_lsp" }, { name = "luasnip" }, { name = "path" },
        },

        snippet = {
            expand = function(args)
                snip.lsp_expand(args.body)
            end,
        },

        mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<CR>"] = cmp.mapping.confirm { select = true },
            ["<C-Space>"] = cmp.mapping.complete {}
        }),
    })
end
