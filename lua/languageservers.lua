local M = {}

function M.config()
    local lspconfig = require("lspconfig")
    local servers = { "tsserver", "vimls", "rust_analyzer", "zls", "ccls", "crystalline", "pylsp", "bashls", "teal_ls", "dockerls", "astro" }

    local overrideattach = function(client)
        if client.server_capabilities.signatureHelpProvider then
            require("lsp-overloads").setup(client, {
                ui = {
                    border = "single",
                },
            })
        end
    end

    local ensure_capabilities = function(cfg)
        return require("coq").lsp_ensure_capabilities(cfg)
    end

    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup(ensure_capabilities({
            on_attach = overrideattach,
        }))
    end

    -- C#
    local pid = vim.fn.getpid()
    local omnisharp_bin = "omnisharp"
    lspconfig.omnisharp.setup(ensure_capabilities({
        handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler,
        },
        cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },

        on_attach = overrideattach,
    }))

    -- HTML
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    lspconfig.html.setup(ensure_capabilities({
        capabilities = capabilities,

        on_attach = overrideattach,
    }))

    -- Json
    lspconfig.jsonls.setup(ensure_capabilities({
        capabilities = capabilities,

        on_attach = overrideattach,
    }))

    -- Zls setting
    vim.g.zig_fmt_autosave = false

    -- Lua
    lspconfig.sumneko_lua.setup(ensure_capabilities({
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
    }))
end

return M
