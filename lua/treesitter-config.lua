local M = {}

function M.config()
    require("nvim-treesitter.configs").setup({
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        endwise = {
            enable = true,
        },
        autotag = {
            enable = true,
        }
    })

    require("nvim-treesitter.highlight").set_custom_captures({
        ["type.builtin"] = "TSKeyword",
        ["constant.builtin"] = "TSKeyword",
        ["keyword"] = "TSKeyword",
        ["conditional"] = "TSKeyword",
        ["repeat"] = "TSKeyword",
        ["keyword.function"] = "TSKeyword",
        ["keyword.operator"] = "TSKeyword",
        ["keyword.return"] = "TSKeyword",
        ["exception"] = "TSKeyword",
        ["include"] = "TSKeyword",
        ["variable"] = "TSField",
        ["type"] = "Type",
        ["punctuation.delimiter"] = "TSPunctBracket",
        ["vairable.builtin"] = "TSKeyword",
        ["boolean"] = "TSKeyword",
    })

    vim.cmd[[hi link TreeSitterContext Normal]]
end

return M
