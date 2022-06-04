local M = {}

function M.config()
    local remap = vim.api.nvim_set_keymap
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    npairs.setup({
        map_bs = false,
        map_cr = false,
        fast_wrap = {},
    })

    -- these mappings are coq recommended mappings unrelated to nvim-autopairs
    remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
    remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
    remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
    remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

    -- skip it, if you use another global object
    _G.MUtils= {}

    MUtils.CR = function()
        if vim.fn.pumvisible() ~= 0 then
            if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
                return npairs.esc('<c-y>')
            else
                return npairs.esc('<c-e>') .. npairs.autopairs_cr()
            end
        else
            return npairs.autopairs_cr()
        end
    end
    remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

    MUtils.BS = function()
        if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
            return npairs.esc('<c-e>') .. npairs.autopairs_bs()
        else
            return npairs.autopairs_bs()
        end
    end
    remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

    npairs.add_rules {
      Rule(' ', ' ')
        :with_pair(function (opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),
      Rule('( ', ' )')
          :with_pair(function() return false end)
          :with_move(function(opts)
              return opts.prev_char:match('.%)') ~= nil
          end)
          :use_key(')'),
      Rule('{ ', ' }')
          :with_pair(function() return false end)
          :with_move(function(opts)
              return opts.prev_char:match('.%}') ~= nil
          end)
          :use_key('}'),
      Rule('[ ', ' ]')
          :with_pair(function() return false end)
          :with_move(function(opts)
              return opts.prev_char:match('.%]') ~= nil
          end)
          :use_key(']')
    }
end

return M
