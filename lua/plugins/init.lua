local uv = vim.uv or vim.loop

if vim.g.plugins_loaded == 1 then
    return
end
vim.g.plugins_loaded = 1

local sep = string.sub(package.config, 1, 1)

local function plugin_config_dir()
    local fname = debug.getinfo(1).short_src
    return vim.fn.fnamemodify(fname, ":h") -- no trailing slash
end

local function find_configs()
    local ret = {}

    local handle = uv.fs_scandir(plugin_config_dir())
    if not handle then
        return ret
    end

    while true do
        local name, _ = uv.fs_scandir_next(handle)
        if not name then
            break
        end

        if name ~= "init.lua" then
            local module_name = "plugins" .. sep .. vim.fn.fnamemodify(name, ":t:r") -- turns dir/file.lua into file
            table.insert(ret, module_name)
        end
    end

    return ret
end

-- To compact the list below
local function c(plugin, config) return { plugin, config = config } end

local function r(plugin, requires) return { plugin, requires = requires } end

-- Plugins with no configuration, do not need to be automatically loaded from a file
local plugins = {
    "mfussenegger/nvim-jdtls", -- Full jdtls support
    "puremourning/vimspector", -- Debugger
    "jbyuki/one-small-step-for-vimkind", -- Lua debugging
    "tpope/vim-sleuth", -- Automatic indent settings
    "ntpeters/vim-better-whitespace", -- Whitespace highlighting
    "Issafalcon/lsp-overloads.nvim", -- Sig help
    "andymass/vim-matchup", -- Better %
    "mbbill/undotree", -- Undo window
    "nvim-lua/plenary.nvim", -- Lua helper functions
    "nvim-telescope/telescope.nvim", -- Fzf replacement
    "jghauser/mkdir.nvim", -- Create missing folders on save
    "stevearc/dressing.nvim", -- Improve default ui
    "kevinhwang91/nvim-bqf", -- Better quickfix window
    "https://bitbucket.org/sw-samuraj/vim-gradle.git", -- Gradle file extension, syntax highlighting, and folding
    "rcarriga/nvim-notify", -- Notification manager
    "tpope/vim-commentary", -- Comment keybinds
    "nvim-neotest/neotest", -- Testing framework
    "rafcamlet/nvim-luapad",
    --- Anything bigger than 2 fields that fit in the above methods shouldn't go here
    r("nvim-treesitter/playground", "nvim-treesitter/nvim-treesitter"), -- Check capture groups and view tree
    r("nvim-treesitter/nvim-treesitter-context", "nvim-treesitter/nvim-treesitter"), -- Show current function or class at top of window
    r("RRethy/nvim-treesitter-endwise", "nvim-treesitter/nvim-treesitter"), -- Automatically insert end
    r("ckolkey/ts-node-action", "nvim-treesitter/nvim-treesitter"), -- Node actions
    c("DNLHC/glance.nvim", function() require("glance").setup() end), -- Show definitions in preview windows
    c("folke/todo-comments.nvim", function() require("todo-comments").setup() end), -- Show todo comments in a project
    c("luukvbaal/stabilize.nvim", function() require("stabilize").setup() end), -- Stabilize window open/close events
    c("alvarosevilla95/luatab.nvim", function() require("luatab").setup() end), -- Tabline
    c("~/gitclone/haste-nvim", function() require("haste").setup({ setclip = true }) end), -- Upload current buffer to haste
    c("norcalli/nvim-colorizer.lua", function() require("colorizer").setup() end), -- Highlight colors
    c("kylechui/nvim-surround", function() require("nvim-surround").setup() end), -- Surround delimiters
    c("danymat/neogen", function() require("neogen").setup({}) end), -- Easy annotations
    c("lewis6991/spellsitter.nvim", function() require("spellsitter").setup({ enable = true }) end), -- Spellchecking
    c("asiryk/auto-hlsearch.nvim", function() require("auto-hlsearch").setup() end), -- Clear search highlight
}

-- Files should return their paq table
for _, module in ipairs(find_configs()) do
    table.insert(plugins, require(module))
end

return require("pckr").add(plugins)
