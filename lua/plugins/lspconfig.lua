local function custom_servers()
    require("lspconfig.configs").msbuild_project_tools_server = {
        default_config = {
            cmd = { "MSBuildProjectTools.LanguageServer.Host" },
            filetypes = { "csproj", "targets" },
            name = "MSBuild Project Tools",
            root_dir = require("lspconfig.util").root_pattern(".git", "*.sln"),
        },
    }
end

return {
    "neovim/nvim-lspconfig", -- LSP Config
    requires = {
        "folke/neodev.nvim", -- Lua lsp config for nvim
        "folke/neoconf.nvim", -- Lua lsp config manager
        "hrsh7th/nvim-cmp",
        "nvimtools/none-ls.nvim", -- Linter management
        "jmederosalvarado/roslyn.nvim/", -- Make roslyn-lsp not broken
    },
    config = function()
        local lspconfig = require("lspconfig")

        custom_servers()

        local client_capabilities = require("lsp").client_capabilities
        local function setup_lspconfig(name, config)
            lspconfig[name].setup(vim.tbl_deep_extend("force", {
                capabilities = client_capabilities(),
            }, config or {}))
        end

        local servers = {
            { "tsserver" },
            {
                "rust_analyzer",
                {
                    settings = {
                        ["rust-analyzer"] = {
                            diagnostics = {
                                disabled = {
                                    "needless_return",
                                },
                            },
                        },
                    },
                },
            },
            {
                "clangd",
                {
                    capabilities = client_capabilities({ offsetEncoding = { "utf-16" } }),
                },
            },
            { "pylsp" },
            { "bashls" },
            { "astro" },
            { "html" },
            { "cssls" },
            { "jsonls" },
            {
                "lua_ls",
                {
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJit",
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            diagnostics = {
                                globals = {
                                    "vim",
                                },
                            },
                        },
                    },
                },
            },
            { "msbuild_project_tools_server" },
            { "sourcekit" },
            { "crystalline" },
        }

        require("roslyn").setup({ -- Roslyn lsp specific setup because it's quirky and special
            dotnet_cmd = "dotnet",
            capabilities = client_capabilities(),
            settings = {
                ["csharp|completion"] = {
                    ["dotnet_provide_regex_completions"] = true,
                    ["dotnet_show_completion_items_from_unimported_namespaces"] = true,
                    ["dotnet_show_name_completion_suggestions"] = true,
                },
                ["csharp|highlighting"] = {
                    ["dotnet_highlight_related_json_components"] = true,
                    ["dotnet_highlight_related_regex_components"] = true,
                },
                ["csharp|inlay_hints"] = {
                    ["csharp_enable_inlay_hints_for_implicit_object_creation"] = true,
                    ["csharp_enable_inlay_hints_for_implicit_variable_types"] = true,
                    ["csharp_enable_inlay_hints_for_lambda_parameter_types"] = true,
                    ["csharp_enable_inlay_hints_for_types"] = true,
                    ["dotnet_enable_inlay_hints_for_indexer_parameters"] = false,
                    ["dotnet_enable_inlay_hints_for_literal_parameters"] = true,
                    ["dotnet_enable_inlay_hints_for_object_creation_parameters"] = true,
                    ["dotnet_enable_inlay_hints_for_other_parameters"] = true,
                    ["dotnet_enable_inlay_hints_for_parameters"] = true,
                    ["dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix"] = false,
                    ["dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name"] = false,
                    ["dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent"] = false,
                },
                ["navigation"] = {
                    ["dotnet_navigate_to_decompiled_sources"] = true,
                },
            },
            on_attach = function() end, -- Blank function. Should be called in another autocmd anyway
        })

        if not vim.g.setup_neodev then
            require("neodev").setup()
            require("neoconf").setup()
        end
        vim.g.setup_neodev = 1

        for _, server in ipairs(servers) do
            setup_lspconfig(server[1], server[2])
        end

        local null_ls = require("null-ls")
        local null_ls_cfg = {
            sources = {
                -- All
                null_ls.builtins.diagnostics.editorconfig_checker.with({ command = "editorconfig-checker" }),

                -- JS, TS, React
                -- null_ls.builtins.code_actions.eslint_d,
                -- null_ls.builtins.diagnostics.eslint_d,
                -- null_ls.builtins.formatting.eslint_d,

                -- Lua
                null_ls.builtins.diagnostics.selene,
                null_ls.builtins.formatting.stylua,

                -- Rust
                -- null_ls.builtins.formatting.rustfmt,

                -- Shell
                -- null_ls.builtins.code_actions.shellcheck,
                -- null_ls.builtins.diagnostics.shellcheck,

                null_ls.builtins.code_actions.ts_node_action,

                -- C#
                -- null_ls.builtins.formatting.dprint.with({
                --     filetypes = { "cs" },
                --     extra_args = { "--config", vim.fn.expand("~/.config/dprint.json") },
                -- }),
            },
        }
        null_ls.setup(null_ls_cfg)
    end,
}
