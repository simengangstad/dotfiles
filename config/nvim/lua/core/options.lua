local opt = vim.opt 

vim.opt.mouse = 'a'

opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent  = true
vim.opt.breakindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

vim.opt.hlsearch = false

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")
