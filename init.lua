require("plugins").load()
require("keybinds").load()

vim.o.number = true
vim.o.encoding = "utf-8"
vim.cmd[[syntax off]]

vim.o.backspace = "indent,eol,start"
vim.o.autoindent = true
vim.cmd[[filetype plugin indent on]]
vim.o.textwidth = 0
vim.o.title = true

vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.shiftwidth = 4

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.incsearch = true
vim.o.laststatus = 2
vim.o.showmode = false
vim.o.signcolumn = "yes"

-- vim.o.fo-=t
vim.o.startofline = true
vim.o.errorbells = false
vim.o.swapfile = false
vim.o.mouse = "a"
vim.o.confirm = true

vim.o.cursorline = true
vim.o.cursorcolumn = true

vim.o.foldmethod = "marker"
vim.o.foldtext=[[getline(v:foldstart).'...'.trim(getline(v:foldend))]]
vim.o.guifont="MesloLGS NF:style=Regular"

vim.o.termguicolors = true
vim.g.cursorhold_updatetime = 1000

vim.o.shell = "/bin/bash"

vim.notify = require("notify")
vim.g.indentLine_fileTypeExclude = { "dashboard" }
vim.g.better_whitespace_filetypes_blacklist = { "dashboard", "packer" }
vim.g.vimspector_base_dir='/home/ppeb/.local/share/nvim/site/pack/packer/start/vimspector'
