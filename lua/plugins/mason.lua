return {
    "williamboman/mason.nvim", -- Package manager for tools
    requires = { "williamboman/mason-lspconfig.nvim" },
    config = function()
        require("mason").setup({
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
        })
        require("mason-lspconfig").setup()
    end,
}
