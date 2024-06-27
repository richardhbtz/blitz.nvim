return function()
    require("nvterm").setup({
        terminals = {
            shell = vim.o.shell,
            list = {},
            type_opts = {
                float = {
                    relative = 'editor',
                    row = 0.18,
                    col = 0.10,
                    width = 0.8,
                    height = 0.6,
                    border = "single",
                },
                horizontal = { location = "rightbelow", split_ratio = .3, border = "single" },
                vertical = { location = "rightbelow", split_ratio = .5, border = "single" },
            }
        },
        behavior = {
            autoclose_on_quit = {
                enabled = false,
                confirm = true,
            },
            close_on_exit = true,
            auto_insert = true,
        },
    })
end
