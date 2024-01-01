local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

local mason_nvim_dap_status, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not mason_nvim_dap_status then
	return
end

mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"clangd",
		"pyright",
		"efm",
		-- "gopls",
	},

	automatic_installation = true,
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"stylua", -- lua formatter
		"ruff", -- rust linter
		"black", -- python formatter
		"clang_format", -- c & c++
		"cpplint",
		"cmake_lint", -- cmake
		"cmake_format",
		-- "golangci-lint", -- go
		-- "gofumpt",
	},

	automatic_installation = true,
})

mason_nvim_dap.setup({
	ensure_installed = {
		"python",
		"codelldb",
		"dvelve",
	},
})
