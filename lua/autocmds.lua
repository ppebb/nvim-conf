local M = {}

function M.load()
    vim.cmd[[
        augroup highlight_yank
            autocmd!
            au TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=1000}
        augroup END

        augroup hover
            autocmd!
            au CursorHold * silent! lua if is_attached(0) then if #vim.diagnostic.get(0) > 0 then vim.diagnostic.open_float(nil, {focus = false, focusable = false, scope = 'cursor'}) else vim.lsp.buf.hover(nil, { focus = false, focusable = false }) end end
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

        augroup lint
            autocmd!
            au BufWritePost * lua require("lint").try_lint()
        augroup END

        augroup italics
            autocmd!
            au ColorScheme * highlight Identifier gui=italic cterm=italic guifg=#cba6f7
            au ColorScheme * highlight link @keyword Identifier
            au ColorScheme * highlight clear @keyword.return | highlight link @keyword.return Identifier
            au ColorScheme * highlight clear @keyword.function | highlight link @keyword.function Identifier
            au ColorScheme * highlight link @conditional Identifier
            au ColorScheme * highlight clear StorageClass | highlight link StorageClass Identifier
            au ColorScheme * highlight clear @type.builtin | highlight link @type.builtin Identifier
            au ColorScheme * highlight clear @type.qualifier | highlight link @type.qualifier Identifier
            au ColorScheme * highlight clear @constant.builtin | highlight link @constant.builtin Identifier
            au ColorScheme * highlight link @operator Identifier
            au ColorScheme * highlight link @character @string
            au ColorScheme * highlight clear @variable | highlight link @variable @property
            au ColorScheme * highlight clear @constructor | highlight link @constructor @type
            au ColorScheme * :highlight @include gui=italic cterm=italic
        augroup END
    ]]
end

return M
