local M = {}

function M.config()
    local actions = require("distant.nav.actions")
    local cfg = {
        servers = {
            ["*"] = {
                file = {
                    mappings = {
                        ["-"] = actions.up,
                    },
                },
                dir = {
                    mappings = {
                        ["<Return>"] = actions.edit,
                        ["-"] = actions.up,
                        ["K"] = actions.mkdir,
                        ["N"] = actions.newfile,
                        ["R"] = actions.rename,
                        ["D"] = actions.remove,
                    },
                },
            },
            [""] = {
                mode = "ssh",
                ssh = {
                    user = "",
                    identity_files = { "" },
                },
                lsp = {
                    [""] = {
                        cmd = { "sourcekit-lsp" },
                        filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
                        root_dir = "",
                    },
                },
            },
        },
    }

    require("distant"):setup(cfg)
end

return M
