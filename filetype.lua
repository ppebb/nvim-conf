vim.filetype.add({
    extension = {
        sln = "solution",
        csproj = "csproj",
        ui = "xml",
        dll = "dll",
        h = "c",
    },
    filename = {
        [".vimspector.json"] = "jsonc",
    },
})
