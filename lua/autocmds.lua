local M = {}

local job = require("plenary.job")

function Kill_EslintD()
    job:new({
        command = "pkill",
        args = { "eslint_d" },
    }):start()
end

function Is_Attached(bufnr)
    local lsp = rawget(vim, "lsp")
    if lsp then
        for _, _ in pairs(lsp.buf_get_clients(bufnr)) do
            return true
        end
    end
    return false
end

function Open_Float()
    local function is_cursor_above_diagnostic(diagnostics)
        local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
        for _, diagnostic in ipairs(diagnostics) do
            if diagnostic.col <= cursor_col and diagnostic.end_col > cursor_col then
                return true
            end
        end
    end


    if Is_Attached(0) then
        local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
        if #diagnostics > 0 and is_cursor_above_diagnostic(diagnostics) then
            vim.diagnostic.open_float(nil, { focus = false, focusable = false, scope = "cursor" })
        else
            vim.lsp.buf.hover()
        end
    end
end

function FloatingWinKeybind()
    if (vim.api.nvim_win_get_config(0).relative ~= "") then
        vim.api.nvim_buf_set_keymap(0, "n", "<ESC><ESC>", ":q<CR>", {})
    end
end

function M.load()
    vim.cmd([[
        augroup highlight_yank
            autocmd!
            au TextYankPost * silent! lua vim.highlight.on_yank { higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=1000 }
        augroup END

        augroup hover
            autocmd!
            au CursorHold * silent! lua Open_Float()
        augroup END

        augroup session
            autocmd!
            au VimEnter * silent! VimspectorLoadSession ~/.cache/vimspector
            au VimLeave * silent! VimspectorMkSession ~/.cache/vimspector
        augroup END

        augroup eslintd
            autocmd!
            au VimLeave * lua Kill_EslintD()
        augroup END

        augroup FloatingWin
            autocmd!
            au WinEnter * lua FloatingWinKeybind()
        augroup END
    ]])
end

return M
