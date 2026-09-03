return {
    "lervag/vimtex",
    config_pre = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = "latexrun"
        vim.g.vimtex_quickfix_ignore_filters = {
            "Underfull",
            "Overfull",
        }
    end,
}
