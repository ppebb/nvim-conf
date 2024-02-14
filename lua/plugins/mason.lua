return {
    "williamboman/mason.nvim", -- Package manager for tools
    requires = { "williamboman/mason-lspconfig.nvim" },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
    end,
}
