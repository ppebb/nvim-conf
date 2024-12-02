-- Some weird stuff is happening with my plugins, and vim.b.did_ftplugin gets
-- set elsewhere. This forces vimtex to load because it otherwise can't.

if vim.b.did_ftplugin then
    vim.b.did_ftplugin = 0
end

local vimtex_ftplugin = vim.fn.stdpath("data") .. "/site/pack/pckr/opt/vimtex/ftplugin/tex.vim"

vim.cmd("source " .. vimtex_ftplugin)
