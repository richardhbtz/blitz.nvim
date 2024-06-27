local key = vim.keymap
local terminal = require("nvterm.terminal")
local builtin = require('telescope.builtin')
local stl = require('nvstl')

vim.g.mapleader = " "

key.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- nvterm
key.set({ 'n', 't' }, '<A-i>', function() terminal.toggle('float') end)
key.set({ 'n', 't' }, '<A-h>', function() terminal.toggle('horizontal') end)
key.set({ 'n', 't' }, '<A-v>', function() terminal.toggle('vertical') end)

-- themes
key.set("n", "<Leader>th", ":Telescope themes<CR>", { noremap = true, silent = true, desc = "Theme Switcher" })

-- telescope
key.set('n', '<Leader>ff', builtin.find_files, {})
key.set('n', '<Leader>fg', builtin.live_grep, {})
key.set('n', '<Leader>fb', builtin.buffers, {})
key.set('n', '<Leader>fh', builtin.help_tags, {})

key.set('n', '<A-l>', function() print(vim.g.colors_name) end, {})

-- nvimtree
key.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree toggle window" })

-- CTRL + S to save | COMMAND + S when on mac
if vim.fn.has('macunix') == 1 then
    key.set('n', '<D-s>', ':w<CR>', { noremap = true, silent = true })
else
    key.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
end

-- CTRL+<hjkl> to switch between windows
key.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
key.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
key.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
key.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
