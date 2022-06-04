local M = {}

function M.config()
    vim.opt.list = true
    vim.opt.listchars:append("space:⋅")
    vim.opt.listchars:append("eol:↴")

    local cfg = {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
    }

    require("indent_blankline").setup(cfg)
end

return M
