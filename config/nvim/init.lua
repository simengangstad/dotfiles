require("plugins-setup")

require("core.options")
require("core.keymaps")
require("core.colorscheme")

require("plugins.nvim-notify")

require("plugins.autopairs")
require("plugins.bufferline")
require("plugins.comment")
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

-- Open Telescope if current buffer is not set
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argv(0) == "" then
			require("telescope.builtin").find_files()
		end
	end,
})
