local M = {}

Lsp_Formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client) return client.name == "null-ls" end,
        bufnr = bufnr,
    })
end

function M.config()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local null_ls = require("null-ls")
    null_ls.setup({
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
            null_ls.builtins.formatting.dprint.with({
                filetypes = { "cs" },
                extra_args = { "--config", vim.fn.expand("~/.config/dprint.json") },
            }),
        },
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function() Lsp_Formatting(bufnr) end,
                })
            end
        end,
    })
end

return M
