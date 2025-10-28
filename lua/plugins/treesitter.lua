return {
    "nvim-treesitter/nvim-treesitter", -- Treesitter, duh
    run = ":TSUpdate",
    config = function()
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
            ensure_installed = {
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
                "jsonc",
                "latex",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "meson",
                "nginx",
                "powershell",
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
            },
        })

        -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        -- parser_config.crystal = {
        --     install_info = {
        --         url = "https://github.com/keidax/tree-sitter-crystal",
        --         files = { "src/parser.c", "src/scanner.c" },
        --         branch = "main",
        --     },
        --     filetype = "crystal",
        -- }

        -- vim.treesitter.language.register("ruby", "crystal")
        vim.treesitter.language.register("xml", "csproj")
    end,
}
