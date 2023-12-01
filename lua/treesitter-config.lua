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
        }
    })

    vim.g.skip_ts_context_commentstring_module = true
    require("ts_context_commentstring").setup({
        enable = true,
        config = {
            cs = { __default = "// %s", __multiline = "/* %S */" },
        },
    })

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    parser_config.xml = {
        install_info = {
            url = "https://github.com/dorgnarg/tree-sitter-xml",
            files = { "src/parser.c" },
            branch = "main",
            location = "tree-sitter-xml/xml",
        },
        filetype = "xml",
    }
end

return M
