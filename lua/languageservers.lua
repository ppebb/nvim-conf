local M = {}

function M.config()
    local lspconfig = require("lspconfig")
    local servers = {
        "tsserver",
        "vimls",
        "rust_analyzer",
        "zls",
        "ccls",
        "crystalline",
        "pylsp",
        "bashls",
        "teal_ls",
        "dockerls",
        "astro",
        "sourcekit",
        "html",
        "cssls",
        "jsonls",
    }

    require("neodev").setup()
    require("neoconf").setup()

    vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
        config = config or { border = "single", focus = false, focusable = false }
        config.focus_id = ctx.method
        if not (result and result.contents) then
            return
        end
        local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents, {})
        markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
        if vim.tbl_isempty(markdown_lines) then
            return
        end
        return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
    end

    local overrideattach = function(client)
        if client.server_capabilities.signatureHelpProvider then
            require("lsp-overloads").setup(client, {
                ui = {
                    border = "single",
                },
            })
        end
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
            on_attach = overrideattach,
            capabilities = capabilities,
        })
    end

    -- C#
    local pid = vim.fn.getpid()
    local omnisharp_bin = "omnisharp"
    lspconfig.omnisharp.setup({
        handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler,
        },
        cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },

        on_attach = overrideattach,
        capabilities = capabilities,
    })

    -- Zls setting
    vim.g.zig_fmt_autosave = false

    -- Lua
    lspconfig.sumneko_lua.setup({
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                completion = {
                    callSnippet = "Replace",
                },
            },
        },

        on_attach = overrideattach,
        capabilities = capabilities,
    })
end

return M
