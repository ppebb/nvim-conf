local M = {}

function M.config()
    require("gitsigns").setup({
        signs = {
            untracked = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        },
        sign_priority = 1,
        signcolumn = true,
        numhl = true,
        current_line_blame = true,
        current_line_blame_opts = {
            delay = 0,
        },
    })
end

return M
