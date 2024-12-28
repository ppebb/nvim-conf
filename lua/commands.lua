local api = vim.api
local yabs = require("yabs")

api.nvim_create_user_command("Build", function() yabs:run_task("run") end, {})

api.nvim_create_user_command("BuildAndRun", function() yabs:run_task("build_and_run") end, {})
