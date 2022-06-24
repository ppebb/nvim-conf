local M = {}

function M.config()
    require("filetype").setup({
        overrides = {
            extensions = {
                h = "c",
            },
        },
    })
end

return M
