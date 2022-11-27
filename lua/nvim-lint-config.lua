local M = {}

function M.config()
    require("lint").linters_by_ft = {
        typescript = { "eslint" },
        javascript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
    --     markdown = { "markdownlint" },
    --     sh = { "shellcheck", "shfmt" }, -- shfmt unconfigured
    --     lua = { "selene", "stylua" }, -- stylua unconfigured
    --     yaml = { "yamllint" },
    --     -- * = { "editorconfig-checker" }, -- unconfigured. Figure out how to run for all filetypes
    }
end

return M
