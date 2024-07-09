return {
    "pianocomposer321/yabs.nvim", -- Build system
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
        local yabs = require("yabs")

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
                c = {
                    tasks = {
                        build = {
                            command = "make",
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
                        yabs:run_task("build", {
                            on_exit = vim.schedule_wrap(function(_, exit_code)
                                if exit_code == 0 then
                                    yabs:run_task("run")
                                end
                            end),
                        })
                    end,
                    type = "lua",
                },
            },
        }

        yabs:setup(cfg)
    end,
}
