vim.filetype.add({
    extension = {
        sln = "solution",
        csproj = "csproj",
        ui = "xml",
        dll = "dll",
        h = "c",
        svg = "html",
        notes = "notes",
        inc = "asm",
    },
    filename = {
        [".vimspector.json"] = "jsonc",
    },
})
