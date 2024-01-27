local M = {}

function M.load()
    return require("pckr").add({
        {
            "williamboman/mason.nvim", -- Package manager for tools
            requires = { "williamboman/mason-lspconfig.nvim" },
            config = function()
                require("mason").setup()
                require("mason-lspconfig").setup()
            end,
        },
        {
            "neovim/nvim-lspconfig", -- LSP Config
            requires = {
                "folke/neodev.nvim", -- Lua lsp config for nvim
                "folke/neoconf.nvim", -- Lua lsp config manager
                "hrsh7th/nvim-cmp",
                "jose-elias-alvarez/null-ls.nvim", -- Linter management
                "jmederosalvarado/roslyn.nvim/",
            },
            config = function() require("languageservers").config() end,
        },
        "mfussenegger/nvim-jdtls", -- Full jdtls support
        "~/gitclone/roslyn.nvim/",
        "puremourning/vimspector", -- Debugger
        "jbyuki/one-small-step-for-vimkind", -- Lua debugging
        "tpope/vim-sleuth", -- Automatic indent settings
        "ntpeters/vim-better-whitespace", -- Whitespace highlighting
        {
            "lewis6991/gitsigns.nvim",
            config = function() require("gitsigns-config").config() end,
        },
        {
            "catppuccin/nvim", -- Catppuccin colorscheme
            as = "catppuccin",
            run = ":CatppuccinCompile",
            config = function() require("catppuccin-config").config() end,
        },
        {
            "nvim-tree/nvim-tree.lua", -- Filetree
            requires = { "nvim-tree/nvim-web-devicons" },
            config = function() require("nvim-tree-config").config() end,
        },
        {
            "hrsh7th/nvim-cmp",
            requires = {
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-nvim-lua",
                "onsails/lspkind.nvim",
                "windwp/nvim-autopairs",
            },
            config = function() require("cmp-config").config() end,
        },
        "Issafalcon/lsp-overloads.nvim", -- Sig help
        {
            "nvim-treesitter/nvim-treesitter", -- Treesitter, duh
            run = ":TSUpdate",
            config = function() require("treesitter-config").config() end,
        },
        {
            "nvim-treesitter/playground", -- Check capture groups and view tree
            requires = { "nvim-treesitter/nvim-treesitter" },
        },
        {
            "nvim-treesitter/nvim-treesitter-context", -- Show current function or class at top of window
            requires = { "nvim-treesitter/nvim-treesitter" },
        },
        {
            "SmiteshP/nvim-navic", -- Show location in status line
            config = function() require("nvim-navic-config").config() end,
        },
        "andymass/vim-matchup", -- Better %
        "mbbill/undotree", -- Undo window
        {
            "lukas-reineke/indent-blankline.nvim", -- Show tabs and spaces
            config = function() require("indent-blankline-config").config() end,
        },
        {
            "windwp/nvim-autopairs", -- Delimiter helper
            config = function() require("autopairs-config").config() end,
        },
        {
            "nvim-lualine/lualine.nvim", -- Statusline
            requires = { "SmiteshP/nvim-navic" },
            config = function() require("lualine-config").config() end,
        },
        {
            "j-hui/fidget.nvim", -- Show lsp load status
            tag = "legacy",
            config = function() require("fidget").setup({ window = { blend = 0 } }) end,
        },
        "nvim-lua/plenary.nvim", -- Lua functions
        "nvim-telescope/telescope.nvim", -- Fzf replacement
        {
            "akinsho/toggleterm.nvim", -- Term window manager
            config = function() require("toggleterm").setup({}) end,
        },
        {
            "anuvyklack/pretty-fold.nvim", -- Foldtext custmization and preview
            requires = {
                "anuvyklack/keymap-amend.nvim",
                "anuvyklack/fold-preview.nvim",
            },
            config = function()
                require("pretty-fold").setup({})
                require("fold-preview").setup()
            end,
        },
        {
            "DNLHC/glance.nvim", -- Show definitions in preview windows
            config = function() require("glance").setup({}) end,
        },
        {
            "folke/todo-comments.nvim", -- Show todo comments in a project
            config = function() require("todo-comments").setup({}) end,
        },
        {
            "luukvbaal/stabilize.nvim", -- Stabilize window open/close events
            config = function() require("stabilize").setup() end,
        },
        "jghauser/mkdir.nvim", -- Create missing folders on save
        "stevearc/dressing.nvim", -- Improve default ui
        {
            "alvarosevilla95/luatab.nvim", -- Tabline
            config = function() require("luatab").setup({}) end,
        },
        "kevinhwang91/nvim-bqf", -- Better quickfix window
        {
            "pianocomposer321/yabs.nvim", -- Build system
            requires = { "nvim-lua/plenary.nvim" },
            config = function() require("yabs-config").config() end,
        },
        "https://bitbucket.org/sw-samuraj/vim-gradle.git", -- Gradle file extension, syntax highlighting, and folding
        "rcarriga/nvim-notify", -- Notification manager
        {
            "RRethy/nvim-treesitter-endwise", -- Automatically insert end
            requires = "nvim-treesitter/nvim-treesitter",
        },
        {
            "~/gitclone/haste-nvim", -- Upload current buffer to haste
            config = function() require("haste").setup({ setclip = true }) end,
        },
        {
            "iamcco/markdown-preview.nvim", -- Markdown preview in browser
            run = "cd app && npm install",
            setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
            ft = { "markdown" },
            config = function() vim.g.mkdp_auto_start = 1 end,
        },
        {
            "windwp/nvim-ts-autotag", -- Html/tsx autotags
            requires = { "nvim-treesitter/nvim-treesitter" },
        },
        {
            "norcalli/nvim-colorizer.lua", -- Highlight colors
            config = function() require("colorizer").setup() end,
        },
        {
            "JoosepAlviste/nvim-ts-context-commentstring", -- Sets comment string basted on cursor position
            requires = "nvim-treesitter/nvim-treesitter",
            config = function() require("nvim-ts-context-commentstring-config").config() end,
        },
        "tpope/vim-commentary", -- Comment keybinds
        {
            "petertriho/nvim-scrollbar", -- Scrollbar
            requires = { "kevinhwang91/nvim-hlslens", "catppuccin/nvim" },
            config = function() require("nvim-scrollbar-config").config() end,
        },
        {
            "kylechui/nvim-surround", -- Surround delimiters
            config = function() require("nvim-surround").setup() end,
        },
        {
            "danymat/neogen", -- Easy annotations
            config = function() require("neogen").setup() end,
        },
        {
            "lewis6991/spellsitter.nvim", -- Spellchecking
            config = function() require("spellsitter").setup({ enable = true }) end,
        },
        "nvim-neotest/neotest", -- Testing framework
        {
            "asiryk/auto-hlsearch.nvim", -- Clear search highlight
            config = function() require("auto-hlsearch").setup() end,
        },
        {
            "chipsenkbeil/distant.nvim", -- Remote editing
            config = function() require("distant-config").config() end,
        },
        {
            "Shatur/neovim-session-manager", -- Session manager
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("session_manager").setup({
                    autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
                })
            end,
        },
        {
            "~/gitclone/ppebboard", -- Dashboard
            config = function() require("ppebboard-config").config() end,
        },
        {
            "~/gitclone/solution-nvim",
            config = function()
                require("solution").setup({
                    width = 40,
                    icons = {
                        folder_open = "",
                        folder_closed = "",
                        folder_empty_open = "",
                        folder_empty_closed = "",
                        folder_symlink = "",
                        folder_symlink_open = "",
                    },
                })
            end,
            rocks = { "xml2lua", "Lua-cURL" },
        },
        -- {
        --     "~/gitclone/cfstealer",
        --     config = function()
        --         require("cfstealer").setup({
        --             languages = {
        --                 cpp = {
        --                     compile = "clang++ {{file}} o.out",
        --                     run = "o.out",
        --                 },
        --             },
        --         })
        --     end,
        --     rocks = { "Lua-cURL" },
        -- },
        "andweeb/presence.nvim", -- Discord rpc
        {
            "ckolkey/ts-node-action",
            requires = { "nvim-treesitter/nvim-treesitter" },
        },
    })
end

return M
