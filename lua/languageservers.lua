local methods = vim.lsp.protocol.Methods

local M = {}

local function is_attached(bufnr)
    local lsp = rawget(vim, "lsp")
    if lsp then
        for _, _ in pairs(lsp.buf_get_clients(bufnr)) do
            return true
        end
    end
    return false
end

local function open_float()
    local function is_cursor_above_diagnostic(diagnostics)
        local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
        for _, diagnostic in ipairs(diagnostics) do
            if diagnostic.col <= cursor_col and diagnostic.end_col > cursor_col then
                return true
            end
        end
    end

    if is_attached(0) then
        local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
        if #diagnostics > 0 and is_cursor_above_diagnostic(diagnostics) then
            vim.diagnostic.open_float(nil, { focus = false, focusable = false, scope = "cursor" })
        else
            vim.lsp.buf.hover()
        end
    end
end

-- Majority of this is stolen from https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/lsp.lua
local function client_capabilities()
    return vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
    )
end

local function on_attach(client, bufnr) -- Hardcode omnisharp in a couple places because it reports incorrect information
    if client.supports_method(methods.textDocument_inlayHint) or client.name == "omnisharp" then
        -- Initial inlay hint display.
        -- Idk why but without the delay inlay hints aren't displayed at the very start.
        vim.defer_fn(function()
            vim.lsp.inlay_hint.enable(bufnr, true)
        end, 500)
    end

    if client.supports_method(methods.textDocument_documentSymbol) then
        require("nvim-navic").attach(client, bufnr)
    end

    if client.supports_method(methods.textDocument_signatureHelp) then
        require("lsp-overloads").setup(client, {
            ui = { border = "single" },
        })

        vim.keymap.set("n", "<leader><Space>", vim.lsp.buf.signature_help, {
            noremap = true,
            buffer = 0
        })
    end

    if client.supports_method(methods.textDocument_hover) or client.name == "omnisharp" then
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = open_float,
            buffer = 0,
        })

        vim.keymap.set("n", "<leader>h", open_float, {
            noremap = true,
            buffer = 0
        })
    end

    -- I hate lua_ls coloring sorry
    if client.name == "lua_ls" then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

local md_namespace = vim.api.nvim_create_namespace("ppebfloat")

local function add_inline_highlights(buf)
    for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
        for pattern, hl_group in pairs({
            ["@%S+"] = "@parameter",
            ["^%s*(Parameters:)"] = "@text.title",
            ["^%s*(Return:)"] = "@text.title",
            ["^%s*(See also:)"] = "@text.title",
            ["{%S-}"] = "@parameter",
        }) do
            local from = 1 ---@type integer?
            while from do
                local to
                from, to = line:find(pattern, from)
                if from then
                    vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
                        end_col = to,
                        hl_group = hl_group,
                    })
                end
                from = to and to + 1 or nil
            end
        end
    end
end

local function float_handler(handler, focusable)
    return function(err, result, ctx, config)
        local bufnr, winnr = handler(
            err,
            result,
            ctx,
            vim.tbl_deep_extend("force", config or {}, {
                border = "single",
                focusable = focusable,
                max_height = math.floor(vim.o.lines * 0.5),
                max_width = math.floor(vim.o.columns * 0.4),
            })
        )

        if not bufnr or not winnr then
            return
        end

        -- Conceal everything.
        vim.wo[winnr].concealcursor = "n"

        add_inline_highlights(bufnr)

        -- Add keymaps for opening links.
        if focusable and not vim.b[bufnr].markdown_keys then
            vim.keymap.set("n", "K", function()
                -- Vim help links.
                local url = (vim.fn.expand("<cWORD>") --[[@as string]]):match("|(%S-)|")
                if url then
                    return vim.cmd.help(url)
                end

                -- Markdown links.
                local col = vim.api.nvim_win_get_cursor(0)[2] + 1
                local from, to
                from, to, url = vim.api.nvim_get_current_line():find("%[.-%]%((%S-)%)")
                if from and col >= from and col <= to then
                    vim.system({ "open", url }, nil, function(res)
                        if res.code ~= 0 then
                            vim.notify("Failed to open URL" .. url, vim.log.levels.ERROR)
                        end
                    end)
                end
            end, { buffer = bufnr, silent = true })
            vim.b[bufnr].markdown_keys = true
        end
    end
end
local lspconfig = require("lspconfig")
local function setup_lspconfig(name, config)
    lspconfig[name].setup(vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = client_capabilities(),
    }, config or {}))
end

function M.config()
    local servers = {
        { "tsserver" },
        { "rust_analyzer" },
        {
            "clangd",
            {
                capabilities = vim.tbl_deep_extend("force", client_capabilities(), { offsetEncoding = { "utf-16" } })
            }
        },
        { "pylsp" },
        { "bashls" },
        { "astro" },
        { "html" },
        { "cssls" },
        { "jsonls" },
        {
            "omnisharp",
            {
                handlers = { ["textDocument/definition"] = require("omnisharp_extended").handler },
                cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
            },
        },
        {
            "lua_ls",
            {
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJit"
                        },
                        completion = {
                            callSnippet = "Replace"
                        }
                    }
                },
            },
        },
    }

    if not vim.g.setup_neodev then
        require("neodev").setup()
        require("neoconf").setup()
    end
    vim.g.setup_neodev = 1

    vim.diagnostic.config({ underline = true, virtual_text = false });

    vim.lsp.handlers[methods.textDocument_hover] = float_handler(vim.lsp.handlers.hover, true)
    vim.lsp.handlers[methods.textDocument_signatureHelp] = float_handler(vim.lsp.handlers.signature_help, true)

    vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
        contents = vim.lsp.util._normalize_markdown(contents, {
            width = vim.lsp.util._make_floating_popup_size(contents, opts),
        })
        vim.bo[bufnr].filetype = "markdown"
        vim.treesitter.start(bufnr)
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

        add_inline_highlights(bufnr)

        return contents
    end

    for _, server in ipairs(servers) do
        setup_lspconfig(server[1], server[2])
    end

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
        on_attach = on_attach,
    }
    null_ls.setup(null_ls_cfg)
end

return M
