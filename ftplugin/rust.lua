local api = vim.api
local uv = vim.uv or vim.loop

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
