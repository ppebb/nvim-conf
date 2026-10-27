return {
    "petertriho/nvim-scrollbar", -- Scrollbar
    branch = "refactor/v2",
    requires = { "kevinhwang91/nvim-hlslens", "catppuccin/nvim" },
    config = function()
        local colors = require("catppuccin.palettes").get_palette()

        require("scrollbar").setup({
            exclude = {
                filetypes = {
                    NvimTree = true,
                },
            },
            scrollbar = {
                track = {
                    highlight = { bg = colors.mantle },
                },
                thumb = {
                    highlight = { bg = colors.surface0 },
                },
            },
        })
    end,
}
