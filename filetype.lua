vim.filetype.add({
    extension = {
        sln = "solution",
        csproj = "csproj",
        ui = "xml",
        dll = "dll",
        h = "c",
        svg = "html",
    },
    filename = {
        [".vimspector.json"] = "jsonc",
    },
})
