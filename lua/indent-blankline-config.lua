local M = {}

function M.config()
    vim.opt.list = true
    vim.opt.listchars:append("space:⋅")
    vim.opt.listchars:append("eol:↴")

    local cfg = {
        indent = {
            char = " ",
        },
        scope = {
            enabled = true,
            show_start = true,
        },
        exclude = {
            filetypes = { "ppebboard" },
        },
    }

    require("ibl").setup(cfg)
end

return M
