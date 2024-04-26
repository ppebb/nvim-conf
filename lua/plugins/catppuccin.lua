return {
    "catppuccin/nvim", -- Catppuccin colorscheme
    as = "catppuccin",
    run = ":CatppuccinCompile",
    config = function()
        local cfg = {
            compile = {
                enabled = true,
            },
            integrations = {
                nvimtree = true,
                treesitter = true,
                indent_blankline = {
                    enabled = true,
                    scope_color = "text",
                },
            },
            dim_inactive = {
                enabled = true,
                shade = "dark",
                percentage = 0.15,
            },
            custom_highlights = function(colors)
                local identifier = { fg = colors.mauve, style = { "italic" } }
                return {
                    -- Treesitter / Semantic tokens
                    ["@keyword"] = identifier,
                    ["@keyword.function"] = identifier,
                    ["@function.macro"] = identifier,
                    ["@keyword.return"] = identifier,
                    ["@keyword.operator"] = identifier,
                    ["@keyword.storage.c_sharp"] = identifier,
                    ["@variable.builtin"] = identifier,
                    ["@constructor.c_sharp"] = { fg = colors.yellow },
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
                    ["@event_name"] = { fg = colors.blue },
                    ["@character"] = { fg = colors.green },
                    ["@lsp.type.event.cs"] = { fg = colors.blue },
                    ["@lsp.type.field.cs"] = { fg = colors.lavender },
                    ["@lsp.type.property.cs"] = { fg = colors.lavender },
                    ["@lsp.type.class_name.cs"] = { fg = colors.yellow },
                    ["@lsp.type.constant.cs"] = { fg = colors.peach },
                    ["@lsp.type.struct_name.cs"] = { fg = colors.yellow },
                    ["@lsp.type.interface_name.cs"] = { fg = colors.yellow },
                    ["@lsp.type.enum_name.cs"] = { fg = colors.yellow },
                    ["@lsp.type.delegate_name.cs"] = { fg = colors.yellow },
                    ["@lsp.type.namespace_name.cs"] = { fg = colors.yellow },
                    ["@lsp.type.namespace.cs"] = { fg = colors.yellow },
                    ["@lsp.mod.callable.rust"] = { fg = colors.blue },
                    ["@class_name"] = { fg = colors.yellow },
                    ["@variable"] = { fg = colors.teal },
                    ["@label"] = { fg = colors.teal },
                    ["@label.json"] = { fg = colors.teal },
                    ["@punctuation"] = { fg = colors.overlay2 },
                    ["@field_name"] = { fg = colors.sky },
                    ["@local_name"] = { fg = colors.teal },
                    -- Luatab
                    ["TabLineFill"] = { bg = colors.crust },
                    -- Solution Explorer
                    ["SolutionExplorerSolution"] = { fg = colors.mauve },
                    ["SolutionExplorerProject"] = { fg = colors.green },
                    ["SolutionExplorerFolder"] = { fg = colors.blue },
                    ["SolutionNugetHeader"] = { fg = colors.base, bg = colors.peach, style = { "bold" } },
                    ["SolutionNugetHighlight"] = { fg = colors.sky },
                    ["CursorColumn"] = { bg = "#2a2b3c" },
                }
            end,
        }

        require("catppuccin").setup(cfg)

        vim.g.catppuccin_flavour = "mocha"
        vim.cmd([[colorscheme catppuccin]])
    end,
}
