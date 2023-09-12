vim.g.mapleader = "\\"

local keymap = vim.keymap

-- Leader space removes highlight
keymap.set("n", "<Leader><space>", "<cmd>noh<CR>", { silent = true })

-- vim maximizer
keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", { silent = true })

-- List keymaps
keymap.set("n", "<leader>km", "<cmd>Telescope keymaps<CR>", { silent = true })
