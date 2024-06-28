M = {
	-- greeter
	greeter_open_on_launch = false,
	greeter_message = true,
	greeter_ascii = "krakedking",

	-- file explorer
	tree_open_on_launch = true, -- will be ignored if greeter is enabled
	tree_on_the_left = true,

	-- editor
	relative_numbers = true,
	leader_key = " ",

	-- theming
	theme = "gruvchad",
	theme_transparency = true,

	-- lsp/treesitter/conform
	languages = {
		"lua",
		"c",
		"cpp",
	},

	-- user plugins
	plugins = {
		{
			"richardhbtz/presence.nvim",
			config = function()
				require("presence").setup({})
			end,
		},
	},
}

return M
