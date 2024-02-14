return {
    "lukas-reineke/indent-blankline.nvim", -- Show tabs and spaces
    config = function()
        vim.opt.list = true
        vim.opt.listchars:append("space:⋅")
        vim.opt.listchars:append("eol:↴")

        local cfg = {
            indent = {
                char = "┃",
                tab_char = { "┃" },
                smart_indent_cap = true,
            },
            scope = {
                enabled = true,
                show_start = true,
            },
            exclude = {
                filetypes = { "ppebboard" },
            },
        }

        require("ibl").setup(cfg)
    end,
}
