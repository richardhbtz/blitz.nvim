local cfg = require("custom.blitz")

local function get_side()
    if cfg.tree_on_the_left then
        return "left"
    else
        return "right"
    end
end

return function()
    require("nvim-tree").setup({

        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        sync_root_with_cwd = true,

        update_focused_file = {
            enable = true,
            update_root = false,
        },

        sort = {
            sorter = "case_sensitive",
        },

        view = {
            side = get_side(),
            adaptive_size = false,
            width = 30,
            signcolumn = "no",
            preserve_window_proportions = true
        },

        renderer = {
            highlight_git = true,
            highlight_opened_files = "none",
            root_folder_label = false,

            indent_markers = {
                enable = false,
            },

            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },

                glyphs = {
                    default = "󰈚",
                    symlink = "",
                    folder = {
                        default = "",
                        empty = "",
                        empty_open = "",
                        open = "",
                        symlink = "",
                        symlink_open = "",
                        arrow_open = "",
                        arrow_closed = "",
                    },
                    git = {
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
        },

        filters = {
            dotfiles = true,
        },

        filesystem_watchers = {
            enable = true,
        },
    })
end
