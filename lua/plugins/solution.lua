return {
    "~/gitclone/solution-nvim",
    config = function()
        require("solution").setup({
            width = 40,
            icons = {
                folder_open = "",
                folder_closed = "",
                folder_empty_open = "",
                folder_empty_closed = "",
                folder_symlink = "",
                folder_symlink_open = "",
            },
        })
    end,
    rocks = { "xml2lua", "Lua-cURL" },
}
