return {
    "mvllow/modes.nvim",
    requires = { "catppuccin/nvim" },
    config = function()
        local mocha = require("catppuccin.palettes").get_palette("mocha")

        local cfg = {
            colors = {
                copy = mocha.yellow,
                delete = mocha.red,
                change = mocha.red, -- Optional param, defaults to delete
                format = mocha.peach,
                insert = mocha.sapphire,
                replace = mocha.blue,
                select = mocha.mauve, -- Optional param, defaults to visual
                visual = mocha.mauve,
            },
        }

        require("modes").setup(cfg)
    end,
}
