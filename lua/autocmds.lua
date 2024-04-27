local api = vim.api
local nvim_tree_api = require("nvim-tree.api")
local job = require("plenary.job")
local uv = vim.uv

api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = (vim.fn.hlexists("HighlightedYankRegion") > 0 and "HighlightedYankRegion" or "IncSearch"),
            timeout = 1000,
        })
    end,
})

local timer
api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    callback = function()
        if timer then
            uv.timer_stop(timer)
            timer = nil
        end

        timer = vim.defer_fn(function() vim.cmd("silent! noautocmd write") end, 2000)
    end,
    nested = true,
    pattern = { "*.rs" },
})

api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        if timer then
            uv.timer_stop(timer)
            timer = nil
        end
    end,
    pattern = { "*.rs" },
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

api.nvim_create_autocmd("VimLeave", {
    callback = function()
        job:new({
            command = "pkill",
            args = { "eslint_d" },
        }):start()
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

api.nvim_create_autocmd("FileType", {
    pattern = "csproj",
    callback = function()
        vim.o.filetype = "xml"
        vim.cmd("syntax on")
    end,
})
