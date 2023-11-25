local M = {}

function M.load()
    vim.keymap.set("i", ";;", "A;<ESC>", { desc = "Append semicolon to the end of the line" })
    vim.keymap.set("n", ";;", "<ESC>A:", { desc = "Append semicolon to the end of the line" })

    vim.keymap.set("n", "fs", "<CMD>Telescope live_grep<CR>")

    vim.keymap.set("n", "<F5>", "<CMD>UndotreeToggle<CR>");
    vim.keymap.set("n", "<F6>", "<CMD>NvimTreeToggle<CR>")

    vim.keymap.set("n", "<leader>y", [["+y]], { noremap = true })
    vim.keymap.set("n", "<leader>p", [["+p]], { noremap = true })

    vim.keymap.set("x", "<", "<gv", { noremap = true })
    vim.keymap.set("x", ">", ">gv", { noremap = true })

    vim.keymap.set("n", "j", "gj", { noremap = true })
    vim.keymap.set("n", "k", "gk", { noremap = true })
    vim.keymap.set("n", "<up>", "<nop>", { noremap = true })
    vim.keymap.set("n", "<down>", "<nop>", { noremap = true })
    vim.keymap.set("n", "<left>", "<nop>", { noremap = true })
    vim.keymap.set("n", "<right>", "<nop>", { noremap = true })

    -- Tab navigation.
    vim.keymap.set("n", "<leader>tc", "<CMD>tabclose<CR>", { desc = "Close tab page" })
    vim.keymap.set("n", "<leader>tn", "<CMD>tab split<CR>", { desc = "New tab page" })
    vim.keymap.set("n", "<leader>to", "<CMD>tabonly<CR>", { desc = "Close other tab pages" })

    local function get_winid(qftype)
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

    local function is_open(qftype) return get_winid(qftype) ~= nil end

    local function close(qftype)
        if is_open(qftype) then
            vim.cmd(qftype .. "close")
        end
    end

    local yabs = require("yabs")
    vim.keymap.set("n", "<F17>", function() yabs:run_task("run") end)
    vim.keymap.set("n", "bnr", function() yabs:run_task("build") end)
    vim.keymap.set("n", "bar", function() yabs:run_task("build_and_run") end)
    vim.keymap.set("n", "<F15>", "<Plug>VimspectorStop")
    vim.keymap.set("n", "<F16>", "<Plug>VimspectorRestart")
    vim.keymap.set("n", "<F18>", "<Plug>VimspectorPause")
    vim.keymap.set("n", "<F21>", "<Plug>VimspectorToggleBreakpoint")
    vim.keymap.set("n", "<leader><F21>", "<Plug>VimspectorToggleConditionalBreakpoint")
    vim.keymap.set("n", "<F20>", "<Plug>VimspectorRunToCursor")
    vim.keymap.set("n", "<F22>", "<Plug>VimspectorStepOver")
    vim.keymap.set("n", "<F23>", "<Plug>VimspectorStepInto")
    vim.keymap.set("n", "<F24>", "<Plug>VimspectorStepOut")
    vim.keymap.set("n", "di", "<Plug>VimspectorBalloonEval")
    vim.keymap.set("n", "<leader>r",
        function()
            vim.cmd("call vimspector#Reset()")
            close("c")
        end,
        { desc = "Close vimspector and yabs windows" }
    )

    vim.keymap.set("n", "cts", "set ts=2 sts=2 noet | retab! | set ts=4 sts=4 et | retab", { desc = "Change tabs to 4 spaces" })
end

return M
