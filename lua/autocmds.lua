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

        augroup session
            autocmd!
            au VimEnter * silent! VimspectorLoadSession ~/.cache/vimspector
            au VimLeave * silent! VimspectorMkSession ~/.cache/vimspector
        augroup END

        augroup italics
            autocmd!
            au ColorScheme * highlight Identifier gui=italic cterm=italic guifg=#cba6f7
            au ColorScheme * highlight link @keyword Identifier
            au ColorScheme * highlight clear @keyword.return | highlight link @keyword.return Identifier
            au ColorScheme * highlight clear @keyword.function | highlight link @keyword.function Identifier
            au ColorScheme * highlight clear @boolean | highlight link @boolean Identifier
            au ColorScheme * highlight link @conditional Identifier
            au ColorScheme * highlight clear @repeat | highlight link @repeat Identifier
            au ColorScheme * highlight clear StorageClass | highlight link StorageClass Identifier
            au ColorScheme * highlight clear @type.qualifier | highlight link @type.qualifier Identifier
            au ColorScheme * highlight clear @constant.builtin | highlight link @constant.builtin Identifier
            au ColorScheme * highlight link @operator Identifier
            au ColorScheme * highlight link @character @string
            au ColorScheme * highlight clear @variable | highlight link @variable @property
            au ColorScheme * highlight clear @variable.builtin | highlight link @variable.builtin Identifier
            au ColorScheme * highlight clear @constructor | highlight link @constructor @type
            au ColorScheme * highlight clear @function.macro | highlight link @function.macro @function
            au ColorScheme * highlight @include gui=italic cterm=italic
            au ColorScheme * highlight clear @include | highlight link @include @keyword
            au ColorScheme * highlight clear @namespace | highlight link @namespace @type
            au ColorScheme * highlight clear jsonBoolean | highlight link jsonBoolean @keyword
            au ColorScheme * highlight clear TSKeyword | highlight link TSKeyword @keyword
            au ColorScheme * highlight clear @type.builtin | highlight link @type.builtin Identifier
        augroup END

        augroup eslintd
            autocmd!
            au VimLeave * lua Kill_EslintD()
        augroup END
    ]])
end

return M
