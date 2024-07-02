vim.filetype.add({
    extension = {
        sln = "solution",
        csproj = "csproj",
        ui = "xml",
        dll = "dll",
    },
    filename = {
        [".vimspector.json"] = "jsonc",
    },
})
