return {
    "windwp/nvim-ts-autotag", -- Html/tsx autotags
    requires = "nvim-treesitter/nvim-treesitter",
    config = function() require("nvim-ts-autotag").setup() end,
}
