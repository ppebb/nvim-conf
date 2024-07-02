return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                untracked = { text = "│" },
            },
            sign_priority = 1,
            signcolumn = true,
            numhl = true,
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 0,
            },
        })
    end,
}
