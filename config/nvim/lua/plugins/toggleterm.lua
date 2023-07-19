local status, toggleterm = pcall(require, "toggleterm")
if not status then
	return
end

toggleterm.setup({
	hide_numbers = true, -- hide the number column in toggleterm buffers
	autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
	direction = "float",
	close_on_exit = true, -- close the terminal window when the process exits
	auto_scroll = true, -- automatically scroll to the bottom on terminal output
	float_opts = {
		border = "curved",

		width = 160,
		height = 50,
		winblend = 3,
	},
	winbar = {
		enabled = false,
		name_formatter = function(term) --  term: Terminal
			return term.name
		end,
	},
})

-- Custom terminal for lazygit
local terminal = require("toggleterm.terminal").Terminal

local lazygit = terminal:new({
	cmd = "lazygit",

	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,

	on_close = function(_)
		vim.cmd("startinsert!")
	end,
})

function _lazygit_toggle()
	lazygit:toggle()
end

-- Keymap

local keymap = vim.keymap

keymap.set("t", "<ESC>", "<cmd>:ToggleTerm<CR>")
keymap.set("t", "<leader>tt", "<cmd>:ToggleTerm<CR>")
keymap.set("n", "<leader>tt", "<cmd>:ToggleTerm<CR>")
keymap.set("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
