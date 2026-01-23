local api = vim.api
local yabs = require("yabs")

api.nvim_create_user_command("Build", function() yabs:run_task("build") end, {})

api.nvim_create_user_command("BuildAndRun", function() yabs:run_task("build_and_run") end, {})

api.nvim_create_user_command("LightMode", function()
    vim.cmd("colorscheme catppuccin-latte")
    vim.cmd("hi CursorColumn guibg=#e9ebf1")
end, {})
