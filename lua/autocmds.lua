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
    command = "silent! w",
    nested = true,
    pattern = { "*.rs" }
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
