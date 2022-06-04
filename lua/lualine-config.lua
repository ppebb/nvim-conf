local M = {}

function M.config()
    local conditions = {
        buffer_not_empty = function ()
            return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end
    }

    local cfg = {
        sections = {
            lualine_c = {},
            lualine_x = {},
        },
        options = {
            theme = "catppuccin"
        },
    }

    local function ins_left(component)
        table.insert(cfg.sections.lualine_c, component)
    end

    local function ins_right(component)
        table.insert(cfg.sections.lualine_x, component)
    end

    ins_left({
        "filename",
        cond = conditions.buffer_not_empty,
    })

    local gps = require("nvim-gps")
    ins_left({
        gps.get_location,
        cond = gps.is_available,
    })

    ins_right({
        function()
            local msg = "No Active LSP"
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            local clients = vim.lsp.get_active_clients()

            if next(clients) == nil then
                return msg
            end

            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                end
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
end

return M
