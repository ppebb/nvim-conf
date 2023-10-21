local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not vim.loop.fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

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
vim.filetype.add({ extension = { csproj = "xml", targets = "xml", ui = "xml", dll = "dll" } })

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
    local sign, git_sign, vimspector_sign_bp, vimspector_sign_other
    for _, s in ipairs(Get_Signs()) do
        if s.name:find("GitSign") then
            git_sign = s
        elseif s.name:find("vimspectorBP") then
            vimspector_sign_bp = s
        elseif s.name:find("vimspector") then
            vimspector_sign_other = s
        else
            sign = s
        end
    end

    local vimspector_text_bp = vimspector_sign_bp
            and ((sign or vimspector_sign_other) and vimspector_sign_bp.text:gsub(" ", "") or vimspector_sign_bp.text)
        or " "

    local vimspector_text_other = ""
    if vimspector_sign_other then
        if vimspector_sign_other.name:find("vimspectorPCBP") then
            vimspector_text_bp = ""
            if sign then
                sign.text = ""
            end
            vimspector_text_other = vimspector_sign_other.text
        elseif sign and vimspector_sign_other then
            vimspector_text_bp = ""
        elseif not sign and vimspector_sign_bp then
            vimspector_text_other = vimspector_sign_other.text:gsub(" ", "")
        else
            vimspector_text_other = " " .. vimspector_sign_other.text
        end
    end

    local components = {
        git_sign and ("%#" .. git_sign.texthl .. "#" .. git_sign.text:gsub(" ", "") .. "%*") or " ",
        sign and ("%#" .. sign.texthl .. "#" .. sign.text:gsub(" ", "") .. "%*") or "",
        vimspector_sign_bp and ("%#" .. vimspector_sign_bp.texthl .. "#" .. vimspector_text_bp .. "%*") or "",
        vimspector_sign_other and ("%#" .. vimspector_sign_other.texthl .. "#" .. vimspector_text_other .. "%*") or "",
        [[%=]],
        [[%{&nu?(&rnu&&v:relnum?v:relnum:v:lnum):''} ]],
    }

    return table.concat(components, "")
end

-- vim.opt.statuscolumn = [[%!v:lua.Column()]]

require("plugins").load()
require("keybinds").load()
require("autocmds").load()
