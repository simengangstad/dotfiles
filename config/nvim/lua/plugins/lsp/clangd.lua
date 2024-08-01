local M = {}

M.config_paths = { "./.nvim-clangd/nvim-clangd.lua", "./.nvim-clangd.lua", "./.nvim/nvim-clangd.lua" }

function M.search_project_config()
	if not pcall(require, "lspconfig") then
		vim.notify("Could not find lspconfig, make sure you load it before clangd.lua", vim.log.levels.ERROR, nil)
		return
	end

	local project_config = ""
	for _, p in ipairs(M.config_paths) do
		local f = io.open(p)
		if f ~= nil then
			f:close()
			project_config = p
			break
		end
	end

	if project_config == "" then
		return
	end

	vim.notify("Found clangd configuration at." .. project_config, vim.log.levels.INFO, nil)

	vim.cmd(":luafile " .. project_config)
end

return M
