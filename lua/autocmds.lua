local M = {}

function M.load()
    vim.cmd[[
        augroup highlight_yank
            autocmd!
            autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=1000}
        augroup END

        augroup hover
            autocmd!
            au CursorHold * silent! lua if is_attached(0) then if #vim.diagnostic.get(0) > 0 then vim.diagnostic.open_float(nil, {focus = false, focusable = false, scope = 'cursor'}) else vim.lsp.buf.hover(nil, {focus = false, focusable = false}) end end
        augroup END

        augroup Vimspector
            autocmd!
            au VimEnter * :VimspectorLoadSession ~/.cache/vimspector
            au VimLeave * :VimspectorMkSession ~/.cache/vimspector
        augroup END

        " auto_start in settings broke for some reason
        augroup coq
            autocmd!
            au VimEnter * :COQnow --shut-up
        augroup END
    ]]
end

return M
