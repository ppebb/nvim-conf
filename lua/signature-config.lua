local M = {}

function M.config()
    local cfg = {
        bind = true,
        hi_parameter = "LspSignatureActiveParameter",

        hint_prefix = "Hint: ",

        max_width = 150,

        handler_opts = {
            border = "single"
        },

        always_trigger = true,

        padding = ' ',
    }

    require("lsp_signature").setup(cfg)
end

return M
