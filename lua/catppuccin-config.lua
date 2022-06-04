local M = {}

function M.config()
    local cfg = {
        integrations = {
            nvimtree = {
                enabled = false,
            },
            gitgutter = true,
        },
    }

    require("catppuccin").setup(cfg)

    vim.g.catppuccin_flavour = "mocha"
    vim.cmd[[colorscheme catppuccin]]
end

return M
