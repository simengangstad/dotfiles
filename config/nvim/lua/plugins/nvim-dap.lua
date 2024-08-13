local dap_status, dap = pcall(require, "dap")
if not dap_status then
	return
end

dap.set_log_level("INFO")

dap.configurations = {

	python = {
		{
			name = "Launch file",
			type = "python",
			request = "launch",

			program = "${file}",
			pythonPath = function()
				local cwd = vim.fn.getcwd()
				if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
					return cwd .. "/venv/bin/python"
				elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
					return cwd .. "/.venv/bin/python"
				else
					return "/usr/bin/python3"
				end
			end,
		},
	},

	cpp = {
		{
			name = "Launch",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
			runInTerminal = true,
		},
	},
}

dap.adapters = {

	lldb = {
		name = "lldb",
		type = "server",
		port = "${port}",
		executable = {
			command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
			args = { "--port", "${port}" },
		},
	},

	python = {
		type = "executable",
		command = "python3",
		args = { "-m", "debugpy.adapter" },
	},
}

local dap_ui_status, ui = pcall(require, "dapui")
if not (dap_status and dap_ui_status) then
	return
end

ui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	expand_lines = false,
	layouts = {
		{
			elements = {
				"scopes",
				"watches",
				"stacks",
				"breakpoints",
			},
			size = 0.2,
			position = "right",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 0.2,
			position = "bottom",
		},
	},
	floating = {
		max_height = nil,
		max_width = nil,
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil,
	},
})

-- Start debugging session
vim.keymap.set("n", "<leader>ds", function()
	dap.continue()
	ui.open({})
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
end)

-- Set breakpoints, get variable values, step into/out of functions, etc.
vim.keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dn", dap.step_over)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<leader>do", dap.step_out)
vim.keymap.set("n", "<leader>dr", dap.restart)
vim.keymap.set("n", "<leader>dh", ui.eval)
vim.keymap.set("n", "<leader>dC", function()
	dap.clear_breakpoints()
end)

-- Close debugger and clear breakpoints
vim.keymap.set("n", "<leader>de", function()
	ui.close({})
	dap.terminate()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
end)

--- Allow local DAP configuration file
local dap_project_status, dap_projects = pcall(require, "nvim-dap-projects")
if not dap_project_status then
	return
end

dap_projects.search_project_config()
