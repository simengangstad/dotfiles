local opt = vim.opt

vim.opt.mouse = "a"

opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
vim.opt.breakindent = true

opt.wrap = true

opt.ignorecase = true
opt.smartcase = true

vim.opt.hlsearch = false

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

-- opt.backupdir = "$HOME/.cache/nvim/backup"
-- opt.directory = "$HOME/.cache/nvim/swap"
-- opt.undodir = "$HOME/.cache/nvim/undo"
