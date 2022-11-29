local M = {}

function M.config()
    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.formatting.eslint_d,

            null_ls.builtins.diagnostics.selene,
            null_ls.builtins.formatting.stylua,
        },
    })
end

return M
