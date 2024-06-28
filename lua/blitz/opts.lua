local opt = vim.opt
local o = vim.o
local g = vim.g
local wo = vim.wo

local cfg = require("custom.blitz")

require("blitz.keys")
require("blitz.cmds")

vim.g.mapleader = cfg.leader_key
opt.laststatus = 3 -- lualine
opt.tabstop = 4
opt.shiftwidth = 4
opt.termguicolors = true
opt.showmode = false -- not needed
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "no"
opt.inccommand = "split" -- previewing substitutions as you type
opt.undofile = true
opt.hlsearch = true -- highlight on search
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
o.expandtab = true
o.numberwidth = 2
o.ruler = false

if cfg.relative_numbers then
	wo.relativenumber = true
end

if cfg.tree_open_on_launch and not (cfg.greeter_open_on_launch and vim.fn.argc() == 0) then
	require("nvim-tree.api").tree.open()
end

require("nvim-treesitter.configs").setup({
	ensure_installed = get_languages_ts(),
})
