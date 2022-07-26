local M = {}

function M.config()
    local lspconfig = require("lspconfig")

    local overrideattach = function(client)
        if client.server_capabilities.signatureHelpProvider then
            require("lsp-overloads").setup(client, {
                ui = {
                    border = "single",
                },
            })
        end
    end

    -- C#
    local pid = vim.fn.getpid()
    local omnisharp_bin = "/bin/omnisharp"
    lspconfig.omnisharp.setup({
        handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler,
        },
        cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },

        on_attach = overrideattach,
    })

    -- TS
    lspconfig.tsserver.setup({
        on_attach = overrideattach,
    })

    -- HTML
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    lspconfig.html.setup({
        capabilities = capabilities,

        on_attach = overrideattach,
    })

    -- Vimscript
    lspconfig.vimls.setup({
        on_attach = overrideattach,
    })

    -- Rust(:rocket:)
    lspconfig.rust_analyzer.setup({
        on_attach = overrideattach,
    })

    -- Zig
    lspconfig.zls.setup({
        on_attach = overrideattach,
    })
    vim.g.zig_fmt_autosave = false

    -- C, C++, ObjC
    lspconfig.clangd.setup({
        on_attach = overrideattach,
    })

    -- Crystal
    lspconfig.crystalline.setup({
        on_attach = overrideattach,
    })

    -- Python
    lspconfig.pylsp.setup({
        on_attach = overrideattach,
    })

    -- Lua
    lspconfig.sumneko_lua.setup({
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = {
                        "vim",
                        "nnoremap",
                        "nmap",
                        "xnoremap",
                        "noremap",
                    },
                },
            },
        },

        on_attach = overrideattach,
    })

    -- Bash
    lspconfig.bashls.setup({
        on_attach = overrideattach,
    })

    -- Teal
    lspconfig.teal_ls.setup({
        on_attach = overrideattach,
    })

    -- Docker
    lspconfig.dockerls.setup({
        on_attach = overrideattach,
    })
end

return M
