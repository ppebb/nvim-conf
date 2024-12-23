local api = vim.api

return {
    "nvim-tree/nvim-tree.lua", -- Filetree
    requires = { "nvim-tree/nvim-web-devicons", "~/gitclone/solution-nvim" },
    config = function()
        local cfg = {
            open_on_tab = true,
            auto_reload_on_write = true,
            reload_on_bufenter = true,
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
            on_attach = require("solution.integrations.nvim-tree").on_attach,
        }

        require("nvim-web-devicons").setup({
            override_by_extension = {
                ["dll"] = {
                    icon = "",
                    color = "#6d8086",
                    cterm_color = "66",
                    name = "Dll",
                },
            },
        })

        require("nvim-tree").setup(cfg)

        -- Automatically close the tabpage when nvim tree is the last window open
        vim.api.nvim_create_autocmd("QuitPre", {
            callback = function()
                local tree_wins = {}
                local floating_wins = {}
                local wins = vim.api.nvim_list_wins()

                for _, win in ipairs(wins) do
                    local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
                    if bufname:match("NvimTree_") ~= nil then
                        table.insert(tree_wins, win)
                    end
                    if vim.api.nvim_win_get_config(win).relative ~= "" then
                        table.insert(floating_wins, win)
                    end
                end

                if 1 == #wins - #floating_wins - #tree_wins then
                    -- Should quit, so we close all invalid windows.
                    for _, w in ipairs(tree_wins) do
                        vim.api.nvim_win_close(w, true)
                    end
                end
            end,
        })
    end,
}
