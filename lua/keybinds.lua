local M = {}

function M.load()
    require("mapx").setup({
        global = true,
    })

    map(";;", "A;<ESC>", "silent")
    imap(";;", "<ESC>A;", "silent")

    nnoremap("fs", ":Telescope live_grep<CR>", "silent")

    nnoremap("<F5>", ":UndotreeToggle<CR>", "silent")
    nnoremap("<F6>", ":NvimTreeToggle<CR>", "silent")

    noremap("<leader>y", [["+y]], "silent")
    noremap("<leader>p", [["+p]], "silent")

    xnoremap("<", "<gv")
    xnoremap(">", ">gv")

    nnoremap("j", "gj")
    nnoremap("k", "gk")
    nnoremap("<up>", "<nop>")
    nnoremap("<down>", "<nop>")
    nnoremap("<left>", "<nop>")
    nnoremap("<right>", "<nop>")

    nnoremap("<leader><leader>", "<c-^>")

    -- Tab navigation.
    nnoremap("<leader>tc", "<CMD>tabclose<CR>", { desc = "Close tab page" })
    nnoremap("<leader>tn", "<CMD>tab split<CR>", { desc = "New tab page" })
    nnoremap("<leader>to", "<CMD>tabonly<CR>", { desc = "Close other tab pages" })

    function Get_Winid(qftype)
        local winid
        if qftype == "l" then
            winid = vim.fn.getloclist(0, { winid = 0 }).winid
        else
            winid = vim.fn.getqflist({ winid = 0 }).winid
        end
        if winid == 0 then
            return nil
        else
            return winid
        end
    end

    function Is_Open(qftype) return Get_Winid(qftype) ~= nil end

    function Close(qftype)
        if Is_Open(qftype) then
            vim.cmd(qftype .. "close")
        end
    end

    local yabs = require("yabs")
    nnoremap("<F17>", function() yabs:run_task("run") end, "silent")
    nnoremap("bnr", function() yabs:run_task("build") end, "silent")
    nnoremap("bar", function() yabs:run_task("build_and_run") end, "silent")
    nmap("<F15>", "<Plug>VimspectorStop", "silent")
    nmap("<F16>", "<Plug>VimspectorRestart", "silent")
    nmap("<F18>", "<Plug>VimspectorPause", "silent")
    nmap("<F21>", "<Plug>VimspectorToggleBreakpoint", "silent")
    nmap("<leader><F21>", "<Plug>VimspectorToggleConditionalBreakpoint")
    nmap("<F20>", "<Plug>VimspectorRunToCursor", "silent")
    nmap("<F22>", "<Plug>VimspectorStepOver", "silent")
    nmap("<F23>", "<Plug>VimspectorStepInto", "silent")
    nmap("<F24>", "<Plug>VimspectorStepOut", "silent")
    nmap("di", "<Plug>VimspectorBalloonEval", "silent")
    nnoremap("<leader>r", [[:call vimspector#Reset() | :lua Close("c")<CR>]], "silent")

    function Is_Attached(bufnr)
        local lsp = rawget(vim, "lsp")
        if lsp then
            for _, _ in pairs(lsp.buf_get_clients(bufnr)) do
                return true
            end
        end
        return false
    end

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "single"
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit =
        Terminal:new({ cmd = "lazygit", hidden = true, direction = "float", float_opts = { border = "single" } })

    local function _lazygit_toggle() lazygit:toggle() end

    nnoremap("<leader>g", function() _lazygit_toggle() end, "silent")

    nnoremap("cts", function() vim.cmd([[ set ts=2 sts=2 noet | retab! | set ts=4 sts=4 et | retab ]]) end, "silent")
end

return M
