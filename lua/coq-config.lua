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

    -- Provide completion when a dot is typed
    vim.api.nvim_set_keymap('i', '.', '<cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(".<C-x><C-u><C-e>", true, false, true), "n", true)<CR>', { noremap = true })
end

return M
