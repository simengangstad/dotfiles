-- Makes it possible for projects to have project-specific vim configurations

local M = {}

M.config_paths = { "./.nvim/config.lua", "./.nvim-config.lua" }

function M.search_project_config()
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

	vim.notify("Found project configuration at." .. project_config, vim.log.levels.INFO, nil)

	vim.cmd(":luafile " .. project_config)
end

return M
