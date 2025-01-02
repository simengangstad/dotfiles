local set = vim.keymap.set

-- Use telescope for LSP. FzfLua doesn't play well with clangd
set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Goto Definition" })
set("n", "gr", "<cmd>Telescope lsp_references <cr>", { desc = "References", nowait = true })
set("n", "gI", "<cmd>Telescope lsp_implementations<cr>", { desc = "Goto Implementation" })
set("n", "gy", "<cmd>Telescope lsp_typedefs<cr>", { desc = "Goto T[y]pe Definition" })
