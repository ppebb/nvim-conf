local api = vim.api
local yabs = require("yabs")
local lualine = require("lualine")

api.nvim_create_user_command("Build", function() yabs:run_task("build") end, {})

api.nvim_create_user_command("BuildAndRun", function() yabs:run_task("build_and_run") end, {})

api.nvim_create_user_command("LightMode", function()
    vim.cmd("colorscheme catppuccin-latte")
    vim.cmd("hi CursorColumn guibg=#e9ebf1")
    local lualine_config = lualine.get_config()
    lualine_config.options.theme = "catppuccin-latte"
    lualine.setup(lualine_config)
end, {})

api.nvim_create_user_command("DarkMode", function()
    vim.cmd("colorscheme catppuccin-mocha")
    local lualine_config = lualine.get_config()
    lualine_config.options.theme = "catppuccin-mocha"
    lualine.setup(lualine_config)
end, {})
