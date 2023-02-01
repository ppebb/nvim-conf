local M = {}

function M.config()
    local cfg = {
        compile = {
            enabled = true,
        },
        integrations = {
            nvimtree = true,
            treesitter = true,
        },
        dim_inactive = {
            enabled = true,
            shade = "dark",
            percentage = 0.15,
        },
        custom_highlights = function(colors)
            local identifier = { fg = colors.mauve, style = { "italic" } }
            return {
                ["@keyword"] = identifier,
                ["@keyword.function"] = identifier,
                ["@keyword.return"] = identifier,
                ["@constant.builtin"] = identifier,
                ["@type.builtin"] = identifier,
                ["@type.qualifier"] = identifier,
                ["@storageclass"] = identifier,
                ["@boolean"] = identifier,
                ["@operator"] = identifier,
                ["@include"] = identifier,
                ["@repeat"] = identifier,
                ["@method"] = { fg = colors.blue },
                ["@method.call"] = { fg = colors.blue },
                ["@character"] = { fg = colors.green },
                ["@namespace"] = { fg = colors.yellow, style = {} },
                ["@constructor"] = { fg = colors.yellow },
                ["@variable"] = { fg = colors.teal },
                ["@label"] = { fg = colors.teal },
                ["@label.json"] = { fg = colors.teal },
            }
        end,
    }

    require("catppuccin").setup(cfg)

    vim.g.catppuccin_flavour = "mocha"
    vim.cmd([[colorscheme catppuccin]])
end

return M
