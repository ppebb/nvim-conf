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

function M.load()
    vim.cmd([[
        augroup highlight_yank
            autocmd!
            au TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=1000}
        augroup END

        augroup hover
            autocmd!
            au CursorHold * silent! lua if Is_Attached(0) then if #vim.diagnostic.get(0) > 0 then vim.diagnostic.open_float(nil, {focus = false, focusable = false, scope = 'cursor'}) else vim.lsp.buf.hover(nil, { focus = false, focusable = false }) end end
        augroup END

        augroup coq
            autocmd!
            au VimEnter * COQnow --shut-up
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
    ]])
end

return M
