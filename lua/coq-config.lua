local M = {}

function M.config()
    vim.g.coq_settings = {
        auto_start = "shut-up",
        clients = {
            lsp = {
                enabled = true,
                weight_adjust = 1.9,
            },
            buffers = {
                enabled = true,
                weight_adjust = -1.9,
            },
            tree_sitter = {
                enabled = false,
            },
            paths = {
                preview_lines = 4,
            },
        },
        display = {
            preview = {
                border = "single",
            },
        },
        keymap = {
            recommended = false,
        }
    }
end

return M
