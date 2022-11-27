local M = {}

function M.config()
    require("hover").setup({
        init = function()
            require("hover.providers.lsp")
            require("hover.providers.gh")
        end,
        preview_opts = {
            border = "single",
        },
        preview_window = false,
        title = true,
    })
end

return M
