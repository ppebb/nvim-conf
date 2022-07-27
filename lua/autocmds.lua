local M = {}

function M.load()
    vim.cmd[[
        augroup highlight_yank
            autocmd!
            autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=1000}
        augroup END

        augroup bindings
            autocmd!
            au CursorHold * silent! lua if is_attached(0) then if #vim.diagnostic.get(0) > 0 then vim.diagnostic.open_float(nil, {focus = false, focusable = false, scope = 'cursor'}) else vim.lsp.buf.hover(nil, {focus = false, focusable = false}) end end
        augroup END

        augroup vimspector
            autocmd!
            au VimEnter * silent! VimspectorLoadSession ~/.cache/vimspector.session
            au VimLeave * silent! VimspectorMkSession ~/.cache/vimspector.session
        augroup END
    ]]
end

return M
