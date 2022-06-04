local M = {}

function M.config()
    vim.g.coq_settings = {
        auto_start = "shut-up",
        clients = {
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
