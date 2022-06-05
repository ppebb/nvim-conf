local M = {}

function M.config()
    require("coq_3p") {
        { src = "nvimlua", short_name = "nLUA" },
        { src = "figlet", short_name = "BIG", trigger = "!big" },
    }
end

return M
