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

-- enable keybinds for available lsp server
local keymap = vim.keymap

local on_attach = function(_, bufnr)
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
	keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.offsetEncoding = { "utf-16" }

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

---- Python ----
lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

---- C/C++ ----
local build_clangd_command = function()
	local path = ""
	local handle = io.popen("which avr-gcc")

	if handle ~= nil then
		local output = handle:read("*a")
		path = output:gsub("[\n\r]", "")
		-- We want to allow for g++ as well, so replace with a wildcard
		path = path:gsub("gcc$", "g*")
		handle:close()
	end

	return {
		"clangd",
		string.format("--query-driver=%s", path),
	}
end

lspconfig["clangd"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = build_clangd_command(),
})

---- Lua ----
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
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
	capabilities = capabilities,
	on_attach = on_attach,
})

---- Go ----
lspconfig["gopls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
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

---- TypeScript ----
lspconfig["tsserver"].setup({ capabilities = capabilities, on_attach = on_attach })

---- Godot ----
lspconfig["gdscript"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	},
})

lspconfig["efm"].setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)

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

---- Formatting ----
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

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
		diagnostics.cpplint.with({
			args = {
				"-filter",
				"-legal/copyright,-build/include_subdir",
			},
		}),
		formatting.cmake_format,
		diagnostics.cmake_lint,
		-- formatting.gofumpt,
		-- diagnostics.golangci_lint,
		formatting.prettier,
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
