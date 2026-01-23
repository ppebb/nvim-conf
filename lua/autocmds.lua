local api = vim.api

api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = (vim.fn.hlexists("HighlightedYankRegion") > 0 and "HighlightedYankRegion" or "IncSearch"),
            timeout = 1000,
        })
    end,
})

local vimspector_session_group = api.nvim_create_augroup("vimspector_session", { clear = true })
api.nvim_create_autocmd("VimEnter", {
    command = "silent! VimspectorLoadSession ~/.cache/vimspector",
    group = vimspector_session_group,
})

api.nvim_create_autocmd("VimLeave", {
    command = "silent! VimspectorMkSession ~/.cache/vimspector",
    group = vimspector_session_group,
})

api.nvim_create_autocmd("User", {
    pattern = "VimspectorUICreated",
    group = vimspector_session_group,
    callback = function(_)
        local vimspector_wins = vim.g.vimspector_session_windows

        if not vimspector_wins.watches then
            return
        end

        api.nvim_win_set_width(vimspector_wins.watches, 50)
    end,
})

api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        vim.cmd("wincmd L")
        api.nvim_set_option_value("cursorcolumn", false, { scope = "local" })
        api.nvim_set_option_value("cursorline", false, { scope = "local" })
    end,
})
