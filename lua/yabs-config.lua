local M = {}

function M.config()
    local cfg = {
        languages = {
                cs = {
                    tasks = {
                        build = {
                            command = "dotnet build",
                            output = "quickfix",
                        },
                    },
                },
                rust = {
                    tasks = {
                        build = {
                            command = "cargo build",
                            output = "quickfix",
                        },
                    },
                },
            },
        tasks = {
            run = {
                command = "call vimspector#Continue()",
                type = "vim",
            },
            build_and_run = {
                command = function()
                    require("yabs"):run_task("build", {
                        on_exit = vim.schedule_wrap(function(Job, exit_code)
                            if exit_code == 0 then
                                require("yabs"):run_task("run")
                            end
                        end),
                    })
                end,
                type = "lua",
                condition = require("yabs.conditions").file_exists(".vimspector.json"),
            },
        },
    }

    require("yabs"):setup(cfg)
end

return M
