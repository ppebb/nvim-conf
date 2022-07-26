local M = {}

function M.config()
    local cfg = {
        compile = {
            enabled = true,
        },
        integrations = {
            nvimtree = {
                enabled = false,
            },
        },
    }

    require("catppuccin").setup(cfg)

    vim.g.catppuccin_flavour = "mocha"
    vim.cmd[[colorscheme catppuccin]]
end

return M
