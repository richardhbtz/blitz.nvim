M = {
	-- greeter
	greeter_open_on_launch = true,
	greeter_message = true,
	greeter_ascii = "krakedking",

	-- file explorer
	tree_open_on_launch = false, -- will be ignored if greeter is enabled
	tree_on_the_left = true,

	-- editor
	relative_numbers = true,

	-- theming
	theme = "gruvchad",

	-- lsp/treesitter/conform
	languages = {
		"lua",
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
