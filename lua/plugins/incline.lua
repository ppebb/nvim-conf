return {
    "b0o/incline.nvim", -- Floating statuslines
    config = function()
        local helpers = require("incline.helpers")

        local cfg = {
            window = {
                padding = 0,
                margin = { horizontal = 0 },
            },
            render = function(opts)
                local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(opts.buf), ":t")
                local icon, color = require("nvim-web-devicons").get_icon_color(fname)
                local modified = vim.bo[opts.buf].modified

                return {
                    icon and { " ", icon, " ", guibg = color, guifg = helpers.contrast_color(color) } or "",
                    " ",
                    { fname, gui = modified and "bold,italic" or "bold" },
                    " ",
                    guibg = "#44406e",
                }
            end,
        }

        require("incline").setup(cfg)
    end,
}
