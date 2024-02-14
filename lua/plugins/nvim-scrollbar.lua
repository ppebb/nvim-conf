return {
    "petertriho/nvim-scrollbar", -- Scrollbar
    requires = { "kevinhwang91/nvim-hlslens", "catppuccin/nvim" },
    config = function()
        local colors = require("catppuccin.palettes").get_palette()

        local cfg = {
            handle = {
                color = colors.crust,
            },
            handlers = {
                search = true,
            },
        }

        require("scrollbar").setup(cfg)
        require("scrollbar.handlers.search").setup()
    end,
}
