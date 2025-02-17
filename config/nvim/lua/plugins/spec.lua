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

    -- Disable friendly-snippets
    {
        "rafamadriz/friendly-snippets",
        enabled = false,
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

    -- Neo-tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            filesystem = {
                follow_current_file = { enabled = false },
            },
        },
        keys = {
            {
                "<leader>r",
                function()
                    require("neo-tree.command").execute({ toggle = false, dir = LazyVim.root(), reveal = true })
                end,
                desc = "Reveal Current File (in Neo-tree)",
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
                "mypy",

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
