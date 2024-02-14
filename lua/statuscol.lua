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
