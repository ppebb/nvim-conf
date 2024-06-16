return {
    "nvim-lualine/lualine.nvim", -- Statusline
    requires = { "SmiteshP/nvim-navic" },
    config = function()
        local conditions = {
            buffer_not_empty = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end,
        }

        local cfg = {
            sections = {
                lualine_c = {},
                lualine_x = {},
            },
            options = {
                theme = "catppuccin",
            },
        }

        local function ins_left(component) table.insert(cfg.sections.lualine_c, component) end

        local function ins_right(component) table.insert(cfg.sections.lualine_x, component) end

        ins_left({
            "filename",
            cond = conditions.buffer_not_empty,
        })

        local navic = require("nvim-navic")
        ins_left({
            function() return navic.get_location() end,
            cond = function() return navic.is_available() end,
        })

        ins_right({
            function()
                local msg = "No Active LSP"
                local clients = vim.lsp.get_clients({ bufnr = 0 })

                if next(clients) == nil then
                    return msg
                end

                local names = ""
                for _, client in ipairs(clients) do
                    if client.name ~= "null-ls" then
                        names = names .. client.name .. " "
                    end
                end

                if names ~= "" then
                    return names:sub(1, -2)
                end

                return msg
            end,
            icon = " LSP:",
        })

        ins_right({
            "encoding",
        })

        ins_right({
            "fileformat",
        })

        ins_right({
            "filetype",
        })

        ins_right({
            "filesize",
            cond = conditions.buffer_not_empty,
        })

        require("lualine").setup(cfg)
    end,
}
