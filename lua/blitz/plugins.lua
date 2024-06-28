require("blitz.dev")
local cfg = require("custom.blitz")

return {
	"nvim-treesitter/nvim-treesitter",

	{
		"goolord/alpha-nvim",
		config = require("config.alpha"),
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"richardhbtz/blitzline.nvim",

		config = function()
			require("blitzline").setup({})
		end,

		dependencies = {
			{
				"richardhbtz/base46.nvim",
				config = function()
					local present, base46 = pcall(require, "base46")
					if not present then
						return
					end
					local theme_opts = {
						base = "base46",
						theme = cfg.theme,
						transparency = cfg.transparency,
					}
					base46.load_theme(theme_opts)
				end,
			},
		},
	},

	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "Base46Line", { fg = require("base46").get_colors("base46", cfg.theme).line })
			end)
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
			require("ibl").setup({
				indent = { char = "▏", highlight = "Base46Line" },
				scope = { char = "▏", highlight = "Base46Line" },
			})
		end,
	},

	{
		"NvChad/nvterm",
		config = require("config.nvterm"),
	},

	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle" },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = require("config.nvimtree"),
	},

	{
		"neovim/nvim-lspconfig",

		dependencies = {
			{
				"williamboman/mason.nvim",
				config = true,
				cmd = "Mason",
			},
			{ "williamboman/mason-lspconfig.nvim" },
		},

		config = require("config.lsp"),
	},

	-- Autocompletion plugins
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"richardhbtz/lspkind.nvim",
			},

			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},

		event = "InsertEnter",
		config = require("config.cmp"),
	},

	{
		"zapling/mason-conform.nvim",
		config = function()
			require("mason-conform").setup({})
		end,
	},

	-- Autoformat
	{
		"stevearc/conform.nvim",
		lazy = false,

		keys = {
			{
				"<S-A-F>",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},

		opts = {
			notify_on_error = false,

			format_on_save = function()
				return {
					timeout_ms = 500,
					lsp_fallback = true,
				}
			end,

			formatters_by_ft = get_languages_formatter(),
		},
	},

	cfg.plugins,
}
