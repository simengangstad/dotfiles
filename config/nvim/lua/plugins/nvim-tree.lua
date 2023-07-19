-- Settings

local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
	view = {
		adaptive_size = true,
	},
	renderer = {
		root_folder_label = false,
	},
	-- disable window_picker for
	-- explorer to work well with
	-- window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
})

-- Keymap

local keymap = vim.keymap

keymap.set("n", "<leader>n", "<cmd>NvimTreeFocus<CR>")
keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")
keymap.set("n", "<C-f>", "<cmd>NvimTreeFindFile<CR>")
