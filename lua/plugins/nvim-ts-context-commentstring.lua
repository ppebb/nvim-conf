return {
    "JoosepAlviste/nvim-ts-context-commentstring", -- Sets comment string basted on cursor position
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
        vim.g.skip_ts_context_commentstring_module = true
        require("ts_context_commentstring").setup({
            enable = true,
            config = {
                cs = { __default = "// %s", __multiline = "/* %S */" },
            },
        })
    end,
}
