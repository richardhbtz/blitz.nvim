local cfg = require("custom.blitz")

local key = vim.keymap
local terminal = require("nvterm.terminal")
local builtin = require("telescope.builtin")

local function closebuffer()
	if vim.bo.buftype == "terminal" then
		vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
	else
		bufnr = vim.api.nvim_get_current_buf()
		local curBufIndex = require("bufferline.utils").getBufIndex(bufnr)
		local bufhidden = vim.bo.bufhidden
		if bufhidden == "wipe" then
			vim.cmd("bw")
			return
		elseif curBufIndex and #vim.t.bufs > 1 then
			local newBufIndex = curBufIndex == #vim.t.bufs and -1 or 1
			vim.cmd("b" .. vim.t.bufs[curBufIndex + newBufIndex])
		elseif not vim.bo.buflisted then
			vim.cmd("b" .. vim.t.bufs[1] .. " | bw" .. bufnr)
			return
		else
			vim.cmd("enew")
		end

		if not (bufhidden == "delete") then
			vim.cmd("confirm bd" .. bufnr)
		end
	end
	vim.cmd("redrawtabline")
end

vim.g.mapleader = cfg.leader_key

key.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- nvterm
key.set({ "n", "t" }, "<A-i>", function()
	terminal.toggle("float")
end)
key.set({ "n", "t" }, "<A-h>", function()
	terminal.toggle("horizontal")
end)
key.set({ "n", "t" }, "<A-v>", function()
	terminal.toggle("vertical")
end)

-- themes
key.set("n", "<Leader>x", closebuffer)

-- themes
key.set("n", "<Leader>th", ":Telescope themes<CR>", { noremap = true, silent = true, desc = "Theme Switcher" })

-- telescope
key.set("n", "<Leader>ff", builtin.find_files, {})
key.set("n", "<Leader>fg", builtin.live_grep, {})
key.set("n", "<Leader>fb", builtin.buffers, {})
key.set("n", "<Leader>fh", builtin.help_tags, {})

key.set("n", "<A-l>", function()
	print(vim.g.colors_name)
end, {})

-- nvimtree
key.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree toggle window" })

-- CTRL + S to save | COMMAND + S when on mac
if vim.fn.has("macunix") == 1 then
	key.set("n", "<D-s>", ":w<CR>", { noremap = true, silent = true })
else
	key.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
end

-- CTRL+<hjkl> to switch between windows
key.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
key.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
key.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
key.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
