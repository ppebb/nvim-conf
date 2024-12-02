return {
    "lervag/vimtex",
    config_pre = function()
        vim.g.vimtex_view_method = "mupdf"
        vim.g.vimtex_compiler_method = "latexrun"
    end,
}
