vim.o.number = true
vim.o.relativenumber = true
vim.o.encoding = "utf-8"
vim.cmd("set nobomb")
vim.cmd("syntax off")

vim.o.backspace = "indent,eol,start"
vim.o.autoindent = true
vim.cmd([[filetype plugin indent on]])
vim.o.textwidth = 0
vim.o.title = true

vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.fixeol = true

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
vim.o.mousemodel = "extend"
vim.o.confirm = true

vim.o.cursorline = true
vim.o.cursorcolumn = true

vim.o.foldmethod = "expr"
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
vim.o.foldtext = [[getline(v:foldstart).'...'.trim(getline(v:foldend))]]
vim.o.foldlevelstart = 99

vim.o.guifont = "MesloLGS NF:style=Regular"

vim.o.termguicolors = true
vim.g.cursorhold_updatetime = 1000

vim.o.shell = "/bin/zsh"

-- vim.notify = require("notify")
vim.g.better_whitespace_filetypes_blacklist = { "ppebboard" }
vim.g.vimspector_base_dir = "/home/ppeb/.local/share/nvim/site/pack/pckr/opt/vimspector"
vim.cmd("sign define vimspectorBP text=⬤ texthl=WarningMsg")

vim.o.autoread = true
vim.o.scrolloff = 1
vim.o.sidescroll = 1
vim.o.sidescrolloff = 2

vim.o.runtimepath = vim.o.runtimepath:gsub(",/usr/local/lib/nvim", "") .. ",/usr/local/lib/nvim"
vim.o.runtimepath = vim.o.runtimepath .. ",/home/ppeb/.local/share/nvim/roslyn"
vim.o.runtimepath = vim.o.runtimepath .. ",/home/ppeb/gitclone/msbuild-project-tools-server/out/language-server"
