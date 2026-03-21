return {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
        opts.file_ignore_patterns = vim.list_extend(opts.file_ignore_patterns or {}, {
            "build",
        })
    end,
}
