local cfg = require("custom.blitz")

return function()
	local hooks = require("ibl.hooks")
	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, "Base46Line", { fg = require("base46").get_colors("base46", cfg.theme).line })
	end)
	hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	require("ibl").setup({
		indent = { char = "▏", highlight = "Base46Line" },
		scope = { char = "▏", highlight = "Base46Line" },
	})
end
