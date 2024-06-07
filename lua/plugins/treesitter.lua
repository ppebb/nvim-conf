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
        })

        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        parser_config.crystal = {
            install_info = {
                url = "https://github.com/keidax/tree-sitter-crystal",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "main",
            },
            filetype = "crystal",
        }

        vim.treesitter.language.register("ruby", "crystal")
    end,
}
