local ft_parser_map = {
    sh = "bash",
    tex = "latex",
}

local function get_parser(filetype)
    local parser = ft_parser_map[filetype]

    if parser ~= nil then
        return parser
    end

    return filetype
end

return {
    "nvim-treesitter/nvim-treesitter", -- nvim-treesitter replacement
    run = ":TSUpdate",
    config = function()
        local ensure_installed = {
            "asm",
            "bash",
            "c",
            "c_sharp",
            "cmake",
            "cpp",
            -- "crystal",
            "css",
            "csv",
            "diff",
            "dockerfile",
            "embedded_template",
            "gdscript",
            "gdshader",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "go",
            "gomod",
            "gosum",
            "hjson",
            "html",
            "ini",
            "java",
            "javascript",
            "json",
            "latex",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "meson",
            "nginx",
            "python",
            "query",
            "ron",
            "ruby",
            "rust",
            "scheme",
            "scss",
            "sql",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        }

        vim.treesitter.language.register("xml", "csproj")

        local treesitter = require("nvim-treesitter")

        treesitter.install(ensure_installed):wait(300000) -- wait 5 minutes

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "*" },
            callback = function(opts)
                if vim.treesitter.get_parser(opts.buf, get_parser(vim.bo.filetype), nil) ~= nil then
                    vim.treesitter.start(opts.buf)
                    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo[0][0].foldmethod = "expr"
                end
            end,
        })
    end,
}
