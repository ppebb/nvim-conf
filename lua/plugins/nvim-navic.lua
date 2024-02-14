return {
    "SmiteshP/nvim-navic", -- Show location in status line
    config = function()
        local cfg = {
            icons = {
                File = " ",
                Module = " ",
                Namespace = " ",
                Package = " ",
                Class = " ",
                Method = " ",
                Property = " ",
                Field = " ",
                Constructor = " ",
                Enum = " ",
                Interface = " ",
                Function = " ",
                Variable = " ",
                Constant = " ",
                String = " ",
                Number = " ",
                Boolean = " ",
                Array = " ",
                Object = " ",
                Key = " ",
                Null = " ",
                EnumMember = " ",
                Struct = " ",
                Event = " ",
                Operator = " ",
                TypeParameter = " ",
            },
        }

        require("nvim-navic").setup(cfg)
    end,
}
