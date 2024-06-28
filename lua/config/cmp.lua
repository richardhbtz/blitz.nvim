return function()
	local cmp = require("cmp")
	local snip = require("luasnip")
	local lspkind = require("lspkind")
	snip.config.setup({})
	cmp.setup({
		completion = { completeopt = "menu,menuone,noinsert" },

		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				preset = "codicons",
				symbol_map = require("config.misc.icons").cmp_icons,

				maxwidth = 40,
				minwidth = 40,

				ellipsis_char = "...",
				show_labelDetails = true,
				before = function(_, vim_item)
					return vim_item
				end,
			}),
		},

		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
		},

		snippet = {
			expand = function(args)
				snip.lsp_expand(args.body)
			end,
		},

		mapping = cmp.mapping.preset.insert({
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping.confirm({ select = true }),
			["<C-g>"] = cmp.mapping.confirm({ select = true }),

			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-Space>"] = cmp.mapping.complete({}),
		}),
	})
end
