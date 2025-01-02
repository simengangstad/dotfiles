---@format disable
local mrpaw = [[
             *     ,MMM8&&&.            *     
                  MMMM88&&&&&    .            
                 MMMM88&&&&&&&                
     *           MMM88&&&&&&&&                
                 MMM88&&&&&&&&                
                 'MMM88&&&&&&'                
                   'MMM8&&&'      *           
          |\___/|                             
          )     (             .              '
         =\     /=                            
           )===(       *                      
          /     \                             
         \       /                            
          |     |                             
         /       \                            
  _/\_/\_/\__  _/_/\_/\_/\_/\_/\_/\_/\_/\_/\_ 
  |  |  |  |( (  |  |  |  |  |  |  |  |  |  | 
  |  |  |  | ) ) |  |  |  |  |  |  |  |  |  | 
  |  |  |  |(_(  |  |  |  |  |  |  |  |  |  | 
  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | 
  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | 
]]
---@format enable

return {

    {
        "snacks.nvim",
        opts = {
            dashboard = {
                preset = {
                    header = mrpaw,
                },
                sections = {
                    { section = "header" },
                    { section = "keys", indent = 1, padding = 1 },
                    { section = "startup" },
                },
            },
        },
    },

    -- Add catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "macchiato",
        },
    },

    -- Configure LazyVim to load catppuccin
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    },

    -- Disable trouble
    {
        "folke/trouble.nvim",
        enabled = false,
        -- opts will be merged with the parent spec
        opts = { use_diagnostic_signs = true },
    },

    -- Disable blink
    {
        "saghen/blink.cmp",
        enabled = false,
    },

    -- Override nvim-cmp and add cmp-emoji
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-emoji" },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            table.insert(opts.sources, { name = "emoji" })
        end,
    },

    -- Change some telescope options and a keymap to browse plugin files
    {
        "nvim-telescope/telescope.nvim",
        keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
        },
        -- change some options
        opts = {
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                winblend = 0,
            },
        },
    },

    -- LSP config
    {
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            ---@type lspconfig.options
            servers = {},
            inlay_hints = { enabled = false },
        },
    },

    -- Tresitter parsers
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
                "html",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "regex",
                "rust",
                "c",
                "cpp",
                "vim",
                "yaml",
                "toml",
                "cmake",
            },
        },
    },

    -- Bufferline
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                -- Every buffer is a tab
                mode = "tabs",
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diag)
                    local icons = LazyVim.config.icons.diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                        .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
                get_element_icon = function(opts)
                    return LazyVim.config.icons.ft[opts.filetype]
                end,
            },
        },
    },

    -- Lualine
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function(_, opts)
            opts.options = {

                theme = "catppuccin",
                component_separators = "|",
                disabled_filetypes = { "packer", "NvimTree" },
                ignore_focus = { "packer", "NvimTree" },
                globalstatus = true,
                section_separators = { left = "", right = "" },
            }
        end,
    },

    -- Mason
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                -- C & C++
                "clangd",
                "clang-format",

                -- Rust
                "rust-analyzer",

                -- Lua
                "stylua",

                -- Python
                "ruff",
                "mypy",
                "black",

                "shellcheck",

                -- Shell
                "shfmt",
            },
        },
    },

    -- Add extra exclude directories for Rust
    {
        "mrcjkb/rustaceanvim",
        opts = {
            server = {
                default_settings = {
                    ["rust-analyzer"] = {
                        files = {
                            excludeDirs = {
                                ".direnv",
                                ".embuild",
                                ".git",
                                ".github",
                                ".gitlab",
                                "bin",
                                "node_modules",
                                "target",
                                "venv",
                                ".venv",
                            },
                        },
                    },
                },
            },
        },
    },
}
