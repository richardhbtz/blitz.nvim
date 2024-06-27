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

    -- theming
    theme = "tokyonight",

    -- lsp/treesitter/conform
    languages =
    {
        "lua",
        "cpp",
        "c"
    },

    -- user plugins
    plugins = {
        {
            "richardhbtz/presence.nvim",
            config = function()
                require("presence").setup {}
            end
        }
    },
}

return M
