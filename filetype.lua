vim.filetype.add({
    extension = {
        sln = "solution",
        csproj = "csproj",
        ui = "xml",
        dll = "dll",
        h = "c",
        svg = "html",
        notes = "notes",
    },
    filename = {
        [".vimspector.json"] = "jsonc",
    },
})
