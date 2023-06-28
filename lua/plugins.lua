local M = {}

function M.load()
    return require("packer").startup(function(use)
        use("wbthomason/packer.nvim") -- Packer
        use({
            "williamboman/mason.nvim", -- Package manager for tools
            config = function()
                require("mason").setup()
                require("mason-lspconfig").setup()
            end,
            requires = { "williamboman/mason-lspconfig.nvim" },
        })
        use("jose-elias-alvarez/null-ls.nvim") -- Linter management
        use({
            "neovim/nvim-lspconfig", -- LSP Config
            config = function() require("languageservers").config() end,
        })
        use("puremourning/vimspector")
        use("jbyuki/one-small-step-for-vimkind")
        use("tpope/vim-sleuth") -- Automatic indent settings
        use("ntpeters/vim-better-whitespace") -- Whitespace highlighting
        use({
            "lewis6991/gitsigns.nvim",
            config = function() require("gitsigns-config").config() end,
        })
        use({
            "catppuccin/nvim", -- Catppuccin colorscheme
            config = function() require("catppuccin-config").config() end,
            as = "catppuccin",
            run = ":CatppuccinCompile",
        })
        use("rebelot/kanagawa.nvim")
        use({
            "nvim-tree/nvim-tree.lua", -- Filetree
            config = function() require("nvim-tree-config").config() end,
            requires = { "nvim-tree/nvim-web-devicons" }, -- Icons
            after = "solution-nvim",
        })
        use({
            "hrsh7th/nvim-cmp",
            config = function() require("cmp-config").config() end,
            requires = {
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-nvim-lua",
                "onsails/lspkind.nvim",
            },
        })
        use("Issafalcon/lsp-overloads.nvim") -- Sig help
        use({
            "nvim-treesitter/nvim-treesitter", -- Treesitter, duh
            config = function() require("treesitter-config").config() end,
            run = ":TSUpdate",
        })
        use("nvim-treesitter/playground") -- Check capture groups and view tree
        use("nvim-treesitter/nvim-treesitter-context") -- Show current function or class at top of window
        use({
            "SmiteshP/nvim-navic", -- Show location in status line
            config = function() require("nvim-navic-config").config() end,
        })
        use("andymass/vim-matchup") -- Better %
        use("mbbill/undotree") -- Undo window
        use({
            "lukas-reineke/indent-blankline.nvim", -- Show tabs and spaces
            config = function() require("indent-blankline-config").config() end,
        })
        use({
            "windwp/nvim-autopairs", -- Delimiter helper
            config = function() require("autopairs-config").config() end,
        })
        use({
            "nvim-lualine/lualine.nvim", -- Statusline
            config = function() require("lualine-config").config() end,
        })
        use({
            "j-hui/fidget.nvim", -- Show lsp load status
            tag = "legacy",
            config = function() require("fidget").setup({ window = { blend = 0 } }) end,
        })
        use("nvim-lua/plenary.nvim") -- Lua functions
        use("nvim-telescope/telescope.nvim") -- Fzf replacement
        use({
            "akinsho/toggleterm.nvim", -- Term window manager
            config = function() require("toggleterm").setup({}) end,
        })
        use({
            "anuvyklack/pretty-fold.nvim", -- Foldtext custmization and preview
            requires = {
                "anuvyklack/keymap-amend.nvim",
                "anuvyklack/fold-preview.nvim",
            },
            config = function()
                require("pretty-fold").setup({})
                require("fold-preview").setup()
            end,
        })
        use({
            "DNLHC/glance.nvim", -- Show definitions in preview windows
            config = function() require("glance").setup({}) end,
        })
        use({
            "folke/todo-comments.nvim", -- Show todo comments in a project
            config = function() require("todo-comments").setup({}) end,
        })
        use({
            "luukvbaal/stabilize.nvim", -- Stabilize window open/close events
            config = function() require("stabilize").setup() end,
        })
        use("jghauser/mkdir.nvim") -- Create missing folders on save
        use("stevearc/dressing.nvim") -- Improve default ui
        use({
            "alvarosevilla95/luatab.nvim", -- Tabline
            config = function() require("luatab").setup({}) end,
        })
        use("kevinhwang91/nvim-bqf") -- Better quickfix window
        use({
            "pianocomposer321/yabs.nvim", -- Build system
            config = function() require("yabs-config").config() end,
        })
        use("Hoffs/omnisharp-extended-lsp.nvim") -- Omnisharp extensions
        use("mfussenegger/nvim-jdtls") -- Full jdtls support
        use("https://bitbucket.org/sw-samuraj/vim-gradle.git") -- Gradle file extension, syntax highlighting, and folding
        use("rcarriga/nvim-notify") -- Notification manager
        use("b0o/mapx.nvim") -- Easier keybinds in lua
        use("RRethy/nvim-treesitter-endwise") -- Automatically insert end
        use({
            "~/gitclone/haste-nvim", -- Upload current buffer to haste
            config = function() require("haste").setup({ setclip = true }) end,
        })
        use({
            "iamcco/markdown-preview.nvim", -- Markdown preview in browser
            run = "cd app && npm install",
            setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
            ft = { "markdown" },
            config = function() vim.g.mkdp_auto_start = 1 end,
        })
        use("windwp/nvim-ts-autotag") -- Html/tsx autotags
        use({
            "norcalli/nvim-colorizer.lua", -- Highlight colors
            config = function() require("colorizer").setup() end,
        })
        use("JoosepAlviste/nvim-ts-context-commentstring") -- Sets comment string basted on cursor position
        use("tpope/vim-commentary") -- Comment keybinds
        use({
            "petertriho/nvim-scrollbar", -- Scrollbar
            config = function() require("nvim-scrollbar-config").config() end,
            requires = { "kevinhwang91/nvim-hlslens" },
        })
        use({
            "kylechui/nvim-surround", -- Surround delimiters
            config = function() require("nvim-surround").setup() end,
        })
        use({
            "danymat/neogen", -- Easy annotations
            config = function() require("neogen").setup() end,
        })
        use({
            "lewis6991/spellsitter.nvim", -- Spellchecking
            config = function() require("spellsitter").setup({ enable = true }) end,
        })
        use("nvim-neotest/neotest") -- Testing framework
        use("folke/neodev.nvim") -- Lua lsp config for nvim
        use("folke/neoconf.nvim") -- Lua lsp config manager
        use({
            "asiryk/auto-hlsearch.nvim", -- Clear search highlight
            config = function() require("auto-hlsearch").setup() end,
        })
        use({
            "chipsenkbeil/distant.nvim", -- Remote editing
            config = function() require("distant-config").config() end,
        })
        use({
            "Shatur/neovim-session-manager", -- Session manager
            config = function()
                require("session_manager").setup({
                    autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
                })
            end,
        })
        use({
            "~/gitclone/ppebboard", -- Dashboard
            config = function() require("ppebboard-config").config() end,
        })
        use({
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
        })
        -- use({
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
        -- })
        use("andweeb/presence.nvim")
    end)
end

return M
