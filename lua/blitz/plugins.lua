require("blitz.dev")

local cfg = require("custom.blitz")

return
{
    "nvim-treesitter/nvim-treesitter",

    {
        "goolord/alpha-nvim",
        config = require("config.alpha")
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {
        "richardhbtz/nvstl",

        config = function()
            require("nvstl").setup {}
        end,

        dependencies = {
            "richardhbtz/base46.nvim"
        }
    },

    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true,
                    enable_rename = true,
                    enable_close_on_slash = false
                },
            })
        end
    },

    {
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            opts = {},

            config = function()
                require("ibl").setup {
                    scope = {
                        show_exact_scope = false,
                        show_start = false
                    }
                }
            end
        }
    },

    -- TODO
    --{
    --   "folke/persistence.nvim",
    --  event = "BufReadPre"
    --},

    {
        "NvChad/nvterm",
        config = require("config.nvterm")
    },

    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle" },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = require("config.nvimtree")
    },


    -- {
    --   "nvim-lualine/lualine.nvim",
    -- config = require("config.lualine"),
    --dependencies =
    -- {
    --    "dokwork/lualine-ex",
    --  "nvim-lua/plenary.nvim",
    --"richardhbtz/lualine-so-fancy.nvim"
    --}
    --},

    {
        "neovim/nvim-lspconfig",

        dependencies = {
            {
                "williamboman/mason.nvim",
                config = true,
                cmd = "Mason"
            },
            { "williamboman/mason-lspconfig.nvim" },
        },

        config = require("config.lsp"),
    },

    -- Autocompletion plugins
    {
        "hrsh7th/nvim-cmp",
        dependencies =
        {
            { "onsails/lspkind.nvim" },

            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
            },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
        },

        event = "InsertEnter",
        config = require("config.cmp"),
    },

    -- Autoformat
    {
        "stevearc/conform.nvim",
        lazy = false,
        keys = {
            {
                "<S-A-F>",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },

        opts = {
            notify_on_error = false,

            format_on_save = function(_)
                return {
                    timeout_ms = 500,
                    lsp_fallback = true
                }
            end,

            formatters_by_ft = {
                get_languages_formatter()
            },
        },

        cfg.plugins,
    },
}
