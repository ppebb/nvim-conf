require("plugins").load()
require("keybinds").load()
require("autocmds").load()

vim.o.number = true
vim.o.encoding = "utf-8"
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
vim.filetype.add({ extension = { csproj = "xml", targets = "xml" } })

-- vim.notify = require("notify")
vim.g.better_whitespace_filetypes_blacklist = { "ppebboard", "packer" }
vim.g.vimspector_base_dir = "/home/ppeb/.local/share/nvim/site/pack/packer/start/vimspector"
vim.cmd("sign define vimspectorBP text=⬤ texthl=WarningMsg")

vim.o.autoread = true
vim.o.scrolloff = 1
vim.o.sidescroll = 1
vim.o.sidescrolloff = 2

function Get_Signs()
    local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    return vim.tbl_map(
        function(sign) return vim.fn.sign_getdefined(sign.name)[1] end,
        vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs
    )
end

function Column()
    local sign, git_sign, vimspector_sign
    for _, s in ipairs(Get_Signs()) do
        if s.name:find("GitSign") then
            git_sign = s
        elseif s.name:find("vimspector") then
            vimspector_sign = s
        else
            sign = s
        end
    end

    local vimspector_text = vimspector_sign
            and ((sign ~= nil) and vimspector_sign.text:gsub(" ", "") or vimspector_sign.text)
        or " "

    local components = {
        git_sign and ("%#" .. git_sign.texthl .. "#" .. git_sign.text:gsub(" ", "") .. "%*") or " ",
        sign and ("%#" .. sign.texthl .. "#" .. sign.text:gsub(" ", "") .. "%*") or "",
        vimspector_sign and ("%#" .. vimspector_sign.texthl .. "#" .. vimspector_text .. "%*") or " ",
        [[%=]],
        [[%{&nu?(&rnu&&v:relnum?v:relnum:v:lnum):''} ]],
    }

    return table.concat(components, "")
end

vim.opt.statuscolumn = [[%!v:lua.Column()]]
