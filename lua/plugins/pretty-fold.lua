return {
    "anuvyklack/pretty-fold.nvim", -- Foldtext custmization and preview
    requires = {
        "anuvyklack/keymap-amend.nvim",
        "anuvyklack/fold-preview.nvim",
    },
    config = function()
        require("pretty-fold").setup()
        require("fold-preview").setup()
    end,
}
