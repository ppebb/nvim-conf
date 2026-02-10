-- Some weird stuff is happening with my plugins, and vim.b.did_ftplugin gets
-- set elsewhere. This forces vimtex to load because it otherwise can't.

if vim.b.did_ftplugin then
    vim.b.did_ftplugin = 0
end

local vimtex_ftplugin = vim.fn.stdpath("data") .. "/site/pack/pckr/opt/vimtex/ftplugin/tex.vim"

vim.cmd("source " .. vimtex_ftplugin)

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*.tex",
--     callback = function(args)
--         local Job = require("plenary.job")

--         Job:new({
--             command = "tex-fmt",
--             args = { args.file },
--         }):sync()

--         vim.cmd("checktime")
--     end,
-- })

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.tex",
    callback = function() vim.cmd(":VimtexCompile") end,
})

-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--     pattern = "*.tex",
--     nested = true,
--     callback = function() vim.cmd(":write") end,
-- })

-- TODO: Make this work
vim.api.nvim_create_autocmd("VimLeavePre", {
    pattern = "*.tex",
    callback = function()
        local Job = require("plenary.job")

        Job:new({
            command = "bash",
            args = { "-c", "'if pidof zathura > /dev/null; then; killall zathura; fi'" },
            cwd = "/usr/bin",
        }):sync() -- or start()
    end,
})
