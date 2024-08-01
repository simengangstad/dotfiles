local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

local rust_tools_setup, rust_tools = pcall(require, "rust-tools")
if not rust_tools_setup then
	return
end

-- enable keybinds for available lsp server
local keymap = vim.keymap

LSP_ON_ATTACH = function(_, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions
	keymap.set("n", "<leader>rn", ":IncRename ", opts) -- smart rename
	keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=1<CR>", opts) -- show  diagnostics for file
	keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
	keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
	keymap.set("n", "<C-space>", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
end

-- used to enable autocompletion (assign to every lsp server config)
LSP_CAPABILITIES = cmp_nvim_lsp.default_capabilities()
LSP_CAPABILITIES.offsetEncoding = { "utf-16" }

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

---- Python ----
lspconfig["pyright"].setup({
	capabilities = LSP_CAPABILITIES,
	on_attach = LSP_ON_ATTACH,
})

---- C/C++ ----

lspconfig["clangd"].setup({
	capabilities = LSP_CAPABILITIES,
	on_attach = LSP_ON_ATTACH,
})

---- Rust ----
lspconfig["rust_analyzer"].setup({
	capabilities = LSP_CAPABILITIES,
	on_attach = LSP_ON_ATTACH,
})

vim.g.rustfmt_autosave = 1

---- Lua ----
lspconfig["lua_ls"].setup({
	capabilities = LSP_CAPABILITIES,
	on_attach = LSP_ON_ATTACH,
	settings = {
		-- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

---- CMake ----
lspconfig["cmake"].setup({
	capabilities = LSP_CAPABILITIES,
	on_attach = LSP_ON_ATTACH,
})

---- Go ----
lspconfig["gopls"].setup({
	capabilities = LSP_CAPABILITIES,
	on_attach = LSP_ON_ATTACH,
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod" },
	root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
})

---- Godot ----
local port = os.getenv("GDSCRIPT_PORT") or "6005"
local cmd = vim.lsp.rpc.connect("127.0.0.1", port)
local pipe = "/tmp/godot.pipe"

lspconfig["gdscript"].setup({
	capabilities = LSP_CAPABILITIES,
	cmd = cmd,
	on_attach = function(client, bufnr)
		LSP_ON_ATTACH(client, bufnr)
		vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
	end,
	flags = {
		debounce_text_changes = 150,
	},
})

lspconfig["efm"].setup({
	filetypes = { "gd", "gdscript", "gdscript3" },
	on_attach = function(client, bufnr)
		LSP_ON_ATTACH(client, bufnr)

		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,
	flags = {
		debounce_text_changes = 150,
	},

	init_options = { documentFormatting = true },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			gdscript = {
				{ formatCommand = "gdformat -l 80 -", formatStdin = true },
			},
		},
	},
})

-- LSP Diagnostics Options Setup
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignHint", text = "" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

---- Formatting ----
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescriptreact", "typescript" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end,
})

null_ls.setup({
	sources = {
		formatting.stylua,
		formatting.black,
		diagnostics.ruff,
		formatting.clang_format.with({
			extra_args = {
				"--style",
				"{ IndentWidth: 4, AllowShortLoopsOnASingleLine: true, AllowShortBlocksOnASingleLine: true, ColumnLimit: 80, BinPackParameters: false, BinPackArguments: false, AllowAllParametersOfDeclarationOnNextLine: false, AlignConsecutiveMacros: true, FixNamespaceComments: false, NamespaceIndentation: All, AlignConsecutiveAssignments: true, AlignEscapedNewlines: true, AlignOperands: Align, AlignTrailingComments: true, AllowAllArgumentsOnNextLine: false, PenaltyBreakAssignment: 50, PointerAlignment: Left, ReferenceAlignment: Left}",
			},
		}),
		formatting.cmake_format,
		diagnostics.cmake_lint,
		formatting.rustfmt,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- Preserve the location in the file
					local position = vim.api.nvim_win_get_cursor(0)
					local view = vim.fn.winsaveview()
					vim.lsp.buf.format({ async = false })

					-- Clamp the position to the last line if we surpass it
					local lastLine = vim.fn.line("$")
					if position[1] > lastLine then
						position[1] = lastLine
					end

					vim.api.nvim_win_set_cursor(0, position)
					vim.fn.winrestview(view)
				end,
			})
		end
	end,
})

-- Load any project specific configurations
require("plugins.lsp.clangd").search_project_config()
