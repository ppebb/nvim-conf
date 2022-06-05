local M = {}

function M.config()
    local cfg = {
        open_on_tab = true,
        auto_reload_on_write = true,
        reload_on_bufenter = true,
        create_in_closed_folder = true,
        hijack_cursor = true,
        diagnostics = {
            enable = true,
            show_on_dirs = true,
        },
        view = {
            width = 40,
            side = "right",
            preserve_window_proportions = true,
        },
        renderer = {
            add_trailing = true,
            group_empty = true,
            highlight_opened_files = "icon",
            indent_markers = {
                enable = true,
            },
            icons = {
                glyphs = {
                    git = {
                        untracked = "%",
                        ignored = "#",
                    },
                },
                show = {
                    folder_arrow = false,
                },
            },
        },
        trash = {
            cmd = "trash-put",
        },
    }

    require("nvim-tree").setup(cfg)

    vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
            if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
                vim.cmd("quit")
            end
        end
    })
end

return M
