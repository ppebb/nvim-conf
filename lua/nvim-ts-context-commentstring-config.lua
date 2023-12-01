local M = {}

function M.config()
    vim.g.skip_ts_context_commentstring_module = true
    require("ts_context_commentstring").setup({
        enable = true,
        config = {
            cs = { __default = "// %s", __multiline = "/* %S */" },
        },
    })
end

return M
