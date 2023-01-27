local M = {}

function M.config()
    require("nvim-treesitter.configs").setup({
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
        endwise = {
            enable = true,
        },
        autotag = {
            enable = true,
        },
        context_commentstring = {
            enable = true,
            config = {
                cs = { __default = "// %s", __multiline = "/* %S */" },
            },
        },
    })
end

return M
