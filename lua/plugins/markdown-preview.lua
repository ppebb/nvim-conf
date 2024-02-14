return {
    "iamcco/markdown-preview.nvim", -- Markdown preview in browser
    run = "cd app && npm install",
    ft = { "markdown" },
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    config = function() vim.g.mkdp_auto_start = 1 end,
}
