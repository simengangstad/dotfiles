require("plugins-setup")

require("core.options")
require("core.keymaps")
require("core.colorscheme")

require("plugins.nvim-notify")

require("plugins.autopairs")
require("plugins.bufferline")
require("plugins.comment")
require("plugins.copilot")
require("plugins.gitsigns")
require("plugins.lualine")
require("plugins.nvim-cmp")
require("plugins.nvim-dap")
require("plugins.nvim-tree")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.treesitter")

require("plugins.lsp.lspconfig")
require("plugins.lsp.mason")

-- Load any project specific configurations
require("core.project").search_project_config()
