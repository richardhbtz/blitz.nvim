vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd "quit"
        end
    end
})

local api = require("nvim-tree.api")
local Event = api.events.Event
api.events.subscribe(Event.TreeOpen, function()
    api.tree.expand_all()
end)
