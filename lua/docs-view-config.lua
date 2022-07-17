local M = {}

function M.config()
    local cfg = {
        position = "right",
        width = 40,
    }

    require("docs-view").setup(cfg)
end

return M
