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

    local highlights = {
        {
            capture = "@type.builtin",
            group = "TSKeyword",
        },
        {
            capture = "constant.builtin",
            group = "TSKeyword",
        },
        {
            capture = "keyword",
            group = "TSKeyword",
        },
        {
            capture = "conditional",
            group = "TSKeyword",
        },
        {
            capture = "repeat",
            group = "TSKeyword",
        },
        {
            capture = "keword.function",
            group = "TSKeyword",
        },
        {
            capture = "keyword.operator",
            group = "TSKeyword",
        },
        {
            capture = "keyword.return",
            group = "TSKeyword",
        },
        {
            capture = "exception",
            group = "TSKeyword",
        },
        {
            capture = "include",
            group = "TSKeyword",
        },
        {
            capture = "variable",
            group = "TSField",
        },
        {
            capture = "type",
            group = "Type",
        },
        {
            capture = "punctuation.delimiter",
            group = "TSPunctBracket",
        },
        {
            capture = "variable.builtin",
            group = "TSKeyword",
        },
        {
            capture = "boolean",
            group = "TSKeyword",
        },
    }

    for _, highlight in pairs(highlights) do
        vim.api.nvim_set_hl(0, highlight.capture, { link = highlight.group })
    end

    vim.cmd[[hi link TreeSitterContext Normal]]
end

return M
