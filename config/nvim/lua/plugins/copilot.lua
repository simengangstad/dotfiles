local setup, copilot_panel = pcall(require, "copilot.panel")
if not setup then
	return
end

-- Keymap

local keymap = vim.keymap

keymap.set("n", "<leader>co", function()
	copilot_panel.open()
	copilot_panel.refresh()
end)
