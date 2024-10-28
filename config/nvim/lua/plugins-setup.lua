local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
    augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")

	-- theme
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- window management
	use("christoomey/vim-tmux-navigator")
	use("szw/vim-maximizer") -- maximizes and restores current window

	-- commenting with gc
	use("numToStr/Comment.nvim")

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- icons
	use("kyazdani42/nvim-web-devicons")

	-- statusline & bufferline
	use("nvim-lualine/lualine.nvim")
	use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })

	-- fuzzy finding with telescope
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- Completion framework
	use("hrsh7th/nvim-cmp")

	-- Useful completion sources
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/vim-vsnip")
	use("L3MON4D3/LuaSnip")
	use("onsails/lspkind-nvim")

	-- managing & installing lsp servers
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("simrat39/rust-tools.nvim")

	-- configuring lsp servers
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion

	-- formatting & linting
	use("nvimtools/none-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")
	use({
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	})

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- Terminal
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})

	-- Notifications
	use("rcarriga/nvim-notify")

	-- debugging
	use({
		"mfussenegger/nvim-dap",
		"jay-babu/mason-nvim-dap.nvim",
		"rcarriga/nvim-dap-ui",
		"jedrzejboczar/nvim-dap-cortex-debug",
	})

	-- Copilot
	use({
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = true,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<leader>co",
					},
					layout = {
						position = "right", -- | top | left | right
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = false,
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})
		end,
	})

	-- testing
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-go",
		},
		config = function()
			local neotest = require("neotest")
			local map_opts = { noremap = true, silent = true, nowait = true }

			-- get neotest namespace (api call creates or returns namespace)

			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			require("neotest").setup({
				-- your neotest config here
				adapters = {},
			})

			require("neotest").setup({
				quickfix = {
					open = false,
					enabled = false,
				},
				status = {
					enabled = true,
					signs = true, -- Sign after function signature
					virtual_text = false,
				},
				icons = {
					child_indent = "│",
					child_prefix = "├",
					collapsed = "─",
					expanded = "╮",
					failed = "✘",
					final_child_indent = " ",
					final_child_prefix = "╰",
					non_collapsible = "─",
					passed = "✓",
					running = "",
					running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
					skipped = "↓",
					unknown = "",
				},
				floating = {
					border = "rounded",
					max_height = 0.9,
					max_width = 0.9,
					options = {},
				},
				summary = {
					open = "botright vsplit | vertical resize 60",
					mappings = {
						attach = "a",
						clear_marked = "M",
						clear_target = "T",
						debug = "d",
						debug_marked = "D",
						expand = { "<CR>", "<2-LeftMouse>" },
						expand_all = "e",
						jumpto = "i",
						mark = "m",
						next_failed = "J",
						output = "o",
						prev_failed = "K",
						run = "r",
						run_marked = "R",
						short = "O",
						stop = "u",
						target = "t",
						watch = "w",
					},
				},
				highlights = {
					adapter_name = "NeotestAdapterName",
					border = "NeotestBorder",
					dir = "NeotestDir",
					expand_marker = "NeotestExpandMarker",
					failed = "NeotestFailed",
					file = "NeotestFile",
					focused = "NeotestFocused",
					indent = "NeotestIndent",
					marked = "NeotestMarked",
					namespace = "NeotestNamespace",
					passed = "NeotestPassed",
					running = "NeotestRunning",
					select_win = "NeotestWinSelect",
					skipped = "NeotestSkipped",
					target = "NeotestTarget",
					test = "NeotestTest",
					unknown = "NeotestUnknown",
				},
				adapters = {
					require("neotest-go"),
				},
			})

			vim.keymap.set("n", "<localleader>tf", function()
				neotest.run.run(vim.fn.expand("%"))
			end, map_opts)

			vim.keymap.set("n", "<localleader>tm", function()
				neotest.run.run()
			end, map_opts)

			vim.keymap.set("n", "<localleader>to", function()
				neotest.output.open({ last_run = true, enter = true })
			end)

			vim.keymap.set("n", "<localleader>ts", function()
				neotest.summary.toggle()
			end, map_opts)

			vim.keymap.set("n", "<localleader>tl", function()
				neotest.run.run_last({ enter = true })
				neotest.output.open({ last_run = true, enter = true })
			end, map_opts)
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
