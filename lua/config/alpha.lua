local cfg = require("custom.blitz")

return function()
	if not cfg.greeter_open_on_launch or vim.fn.argc() > 0 then
		return
	end

	vim.api.nvim_create_autocmd("User", {
		pattern = "AlphaReady",
		desc = "hide cursor for alpha",
		callback = function()
			local hl = vim.api.nvim_get_hl_by_name("Cursor", true)
			hl.blend = 100
			vim.api.nvim_set_hl(0, "Cursor", hl)
			vim.opt.guicursor:append("a:Cursor/lCursor")
		end,
	})
	vim.api.nvim_create_autocmd("BufUnload", {
		buffer = 0,
		desc = "show cursor after alpha",
		callback = function()
			local hl = vim.api.nvim_get_hl_by_name("Cursor", true)
			hl.blend = 0
			vim.api.nvim_set_hl(0, "Cursor", hl)
			vim.opt.guicursor:remove("a:Cursor/lCursor")
		end,
	})

	local dashboard = require("alpha.themes.dashboard")

	dashboard.section.header.val = require("config.misc.banners")[cfg.greeter_ascii]

	dashboard.section.buttons.val = {
		dashboard.button("r", " Restore", [[<cmd> lua require("persistence").load() <cr>]]),
		dashboard.button("s", " Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
		dashboard.button("q", " Quit", "<cmd> qa <cr>"),
	}

	for _, button in ipairs(dashboard.section.buttons.val) do
		button.opts.hl = "Comment"
		button.opts.hl_shortcut = ""
		button.opts.position = "center"
		button.opts.width = 25
	end

	dashboard.section.header.opts.hl = ""
	dashboard.section.footer.opts.hl = "Keyword"
	dashboard.opts.layout[1].val = 4

	-- close Lazy and re-open when the dashboard is ready
	if vim.o.filetype == "lazy" then
		vim.cmd.close()
		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "AlphaReady",
			callback = function()
				require("lazy").show()
			end,
		})
	end

	require("alpha").setup(dashboard.opts)

	if cfg.greeter_message then
		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "LazyVimStarted",
			callback = function()
				local current_hour = tonumber(os.date("%H"))

				local greeting

				if current_hour < 5 then
					greeting = "  Good night!"
				elseif current_hour < 12 then
					greeting = "󰼰 Good morning!"
				elseif current_hour < 17 then
					greeting = "  Good afternoon!"
				elseif current_hour < 20 then
					greeting = "󰖝  Good evening!"
				else
					greeting = "󰖔  Good night!"
				end

				dashboard.section.footer.val = {
					"",
					greeting,
				}

				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end
	require("alpha").setup(dashboard.opts)
end
