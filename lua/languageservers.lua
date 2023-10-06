local M = {}

function M.config()
    local lspconfig = require("lspconfig")
    local servers = {
        "tsserver",
        "vimls",
        "rust_analyzer",
        "zls",
        -- "ccls",
        "clangd",
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
        "lemminx",
    }

    if not vim.g.setup_neodev then
        require("neodev").setup()
        require("neoconf").setup()
    end
    vim.g.setup_neodev = 1

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

    local overrideattach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
        end

        if client.server_capabilities.signatureHelpProvider then
            require("lsp-overloads").setup(client, {
                ui = {
                    border = "single",
                },
            })
        end

        if client.server_capabilities.documentFormattingProvider or client.name == "omnisharp" then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("lsp_formatting_" .. client.name, { clear = true }),
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        filter = function(c) return c.name == "null-ls" or c.name == "omnisharp" end,
                        bufnr = bufnr,
                    })
                end,
            })
        end

        -- if client.name == "omnisharp" then
        --     client.server_capabilities.inlayHintProvider = true
        --     client.server_capabilities.semanticTokensProvider = {
        --         full = vim.empty_dict(),
        --         legend = {
        --             tokenModifiers = { "static_symbol" },
        --             tokenTypes = {
        --                 "comment",
        --                 "excluded_code",
        --                 "identifier",
        --                 "keyword",
        --                 "keyword_control",
        --                 "number",
        --                 "operator",
        --                 "operator_overloaded",
        --                 "preprocessor_keyword",
        --                 "string",
        --                 "whitespace",
        --                 "text",
        --                 "static_symbol",
        --                 "preprocessor_text",
        --                 "punctuation",
        --                 "string_verbatim",
        --                 "string_escape_character",
        --                 "class_name",
        --                 "delegate_name",
        --                 "enum_name",
        --                 "interface_name",
        --                 "module_name",
        --                 "struct_name",
        --                 "type_parameter_name",
        --                 "field_name",
        --                 "enum_member_name",
        --                 "constant_name",
        --                 "local_name",
        --                 "parameter_name",
        --                 "method_name",
        --                 "extension_method_name",
        --                 "property_name",
        --                 "event_name",
        --                 "namespace_name",
        --                 "label_name",
        --                 "xml_doc_comment_attribute_name",
        --                 "xml_doc_comment_attribute_quotes",
        --                 "xml_doc_comment_attribute_value",
        --                 "xml_doc_comment_cdata_section",
        --                 "xml_doc_comment_comment",
        --                 "xml_doc_comment_delimiter",
        --                 "xml_doc_comment_entity_reference",
        --                 "xml_doc_comment_name",
        --                 "xml_doc_comment_processing_instruction",
        --                 "xml_doc_comment_text",
        --                 "xml_literal_attribute_name",
        --                 "xml_literal_attribute_quotes",
        --                 "xml_literal_attribute_value",
        --                 "xml_literal_cdata_section",
        --                 "xml_literal_comment",
        --                 "xml_literal_delimiter",
        --                 "xml_literal_embedded_expression",
        --                 "xml_literal_entity_reference",
        --                 "xml_literal_name",
        --                 "xml_literal_processing_instruction",
        --                 "xml_literal_text",
        --                 "regex_comment",
        --                 "regex_character_class",
        --                 "regex_anchor",
        --                 "regex_quantifier",
        --                 "regex_grouping",
        --                 "regex_alternation",
        --                 "regex_text",
        --                 "regex_self_escaped_character",
        --                 "regex_other_escape",
        --             },
        --         },
        --         range = true,
        --     }
        if client.name == "lua_ls" then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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

    -- Tailwind CSS
    lspconfig.tailwindcss.setup({
        root_dir = require("lspconfig.util").root_pattern("tailwind.config.js", "tailwind.config.cjs"),
        on_attach = overrideattach,
        capabilities = capabilities,
    })

    -- Zls setting
    vim.g.zig_fmt_autosave = false

    -- Lua
    lspconfig.lua_ls.setup({
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

    local null_ls = require("null-ls")
    local null_ls_cfg = {
        sources = {
            -- All
            null_ls.builtins.diagnostics.editorconfig_checker.with({ command = "editorconfig-checker" }),

            -- JS, TS, React
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.formatting.eslint_d,

            -- Lua
            null_ls.builtins.diagnostics.selene,
            null_ls.builtins.formatting.stylua,

            -- Rust
            null_ls.builtins.formatting.rustfmt,

            -- Shell
            null_ls.builtins.code_actions.shellcheck,
            null_ls.builtins.diagnostics.shellcheck,

            -- C#
            -- null_ls.builtins.formatting.dprint.with({
            --     filetypes = { "cs" },
            --     extra_args = { "--config", vim.fn.expand("~/.config/dprint.json") },
            -- }),
        },
        on_attach = overrideattach,
    }
    null_ls.setup(null_ls_cfg)
end

return M
