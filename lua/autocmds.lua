local M = {}

local api = vim.api
local job = require("plenary.job")

api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = (vim.fn.hlexists("HighlightedYankRegion") > 0 and "HighlightedYankRegion" or "IncSearch"),
            timeout = 1000
        })
    end,
})

api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    callback = "w",
    nested = true,
    pattern = { "*.rs" }
})

local function is_attached(bufnr)
    local lsp = rawget(vim, "lsp")
    if lsp then
        for _, _ in pairs(lsp.buf_get_clients(bufnr)) do
            return true
        end
    end
    return false
end

function M.open_float()
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

api.nvim_create_autocmd("CursorHold", {
    callback = function ()
        M:open_float()
    end
})

local vimspector_session_group = api.nvim_create_augroup("vimspector_session", { clear = true })
api.nvim_create_autocmd("VimEnter", {
    command = "silent! VimspectorLoadSession ~/.cache/vimspector",
    group = vimspector_session_group
})

api.nvim_create_autocmd("VimLeave", {
    command = "silent! VimspectorMkSession ~/.cache/vimspector",
    group = vimspector_session_group
})

api.nvim_create_autocmd("VimLeave", {
    callback = function()
        job:new({
            command = "pkill",
            args = { "eslint_d" },
        }):start()
    end
})

-- api.nvim_create_autocmd("WinEnter", {
--     callback = function()
--         if (vim.api.nvim_win_get_config(0).relative ~= "") then
--             vim.api.nvim_buf_set_keymap(0, "n", "<ESC><ESC>", ":q<CR>", {})
--         end
--     end
-- })

return M
