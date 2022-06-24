local M = {}

function M.config()
    local lspconfig = require("lspconfig")

    -- C#
    local pid = vim.fn.getpid()
    local omnisharp_bin = "/bin/omnisharp"
    lspconfig.omnisharp.setup({
        handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler,
        },
        cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
    })

    -- TS
    lspconfig.tsserver.setup({})

    -- HTML
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    lspconfig.html.setup({
        capabilities = capabilities,
    })

    -- Vimscript
    lspconfig.vimls.setup({})

    -- Rust(:rocket:)
    lspconfig.rust_analyzer.setup({})

    -- Zig
    lspconfig.zls.setup({})
    vim.g.zig_fmt_autosave = false

    -- C, C++, ObjC
    lspconfig.clangd.setup({})

    -- Crystal
    lspconfig.crystalline.setup({})

    -- Python
    lspconfig.pylsp.setup({})

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
    })

    -- Bash
    lspconfig.bashls.setup({})
end

return M
