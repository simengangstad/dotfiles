local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

treesitter.setup({
  -- enable syntax highlighting
  highlight = {
    enable = true,
  },

  -- enable indentation
  indent = { enable = true },

  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },

  -- ensure these language parsers are installed
  ensure_installed = {
    "json",
    "yaml",
    "markdown",
    "markdown_inline",
    "bash",
    "lua",
    "vim",
    "gitignore",
    "rust",
    "python",
    "cmake",
    "c",
    "cpp",

},

auto_install = true,
})
