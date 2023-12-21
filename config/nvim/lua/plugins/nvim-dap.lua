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
			type = "cpp",
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
	go = {
		{
			type = "go", -- Which adapter to use
			name = "Debug", -- Human readable name
			request = "launch", -- Whether to "launch" or "attach" to program
			program = "${file}", -- The buffer you are focused on when running nvim-dap
		},
	},
}

dap.adapters = {

	cpp = {
		name = "codelldb server",
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
	go = {
		type = "server",
		port = "${port}",
		executable = {
			command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
			args = { "dap", "-l", "127.0.0.1:${port}" },
		},
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
				"breakpoints",
			},
			size = 0.3,
			position = "right",
		},
		{
			elements = {
				"repl",
			},
			size = 0.3,
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
	ui.toggle({})
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
end)

-- Set breakpoints, get variable values, step into/out of functions, etc.
vim.keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dn", dap.step_over)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<leader>do", dap.step_out)
vim.keymap.set("n", "<leader>dh", ui.eval)
vim.keymap.set("n", "<leader>dC", function()
	dap.clear_breakpoints()
end)

-- Close debugger and clear breakpoints
vim.keymap.set("n", "<leader>de", function()
	ui.toggle({})
	dap.terminate()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
end)
