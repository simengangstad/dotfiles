local setup, null_ls = pcall(require, "null-ls")
if not setup then
    return
end


local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    sources = {
        formatting.stylua,
        formatting.black,
        diagnostics.ruff,
        formatting.clang_format,
        diagnostics.cpplint.with({
            args = {
                "-filter", "-legal/copyright,-build/include_subdir"
            }
        }),
        formatting.cmake_format,
        diagnostics.cmake_lint,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
})
