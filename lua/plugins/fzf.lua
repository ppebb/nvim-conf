return {
    "ibhagwan/fzf-lua",
    config = function()
        local fzf = require("fzf-lua")

        vim.keymap.set("n", "fs", function() fzf.live_grep() end)
        vim.keymap.set("n", "fd", function() fzf.files() end)

        fzf.setup({ "telescope" })
    end,
}
