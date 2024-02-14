return {
    "j-hui/fidget.nvim", -- Show lsp load status
    tag = "legacy",
    config = function() require("fidget").setup({ window = { blend = 0 } }) end,
}
