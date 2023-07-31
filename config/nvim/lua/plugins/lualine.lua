local status, lualine = pcall(require, "lualine")
if not status then
	return
end

-- get lualine nightfly theme
local lualine_nightfly = require("lualine.themes.nightfly")

-- new colors for theme
local new_colors = {
	blue = "#65D1FF",
	green = "#3EFFDC",
	violet = "#FF61EF",
	yellow = "#FFDA7B",
	black = "#000000",
}

-- change nightlfy theme colors
lualine_nightfly.normal.a.bg = new_colors.blue
lualine_nightfly.insert.a.bg = new_colors.green
lualine_nightfly.visual.a.bg = new_colors.violet
lualine_nightfly.command = {
	a = {
		gui = "bold",
		bg = new_colors.yellow,
		fg = new_colors.black,
	},
}

lualine.setup({
	options = {
		theme = "catppuccin",
		component_separators = "|",
		disabled_filetypes = { "packer", "NvimTree" },
		ignore_focus = { "packer", "NvimTree" },
		globalstatus = true,
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{ "mode", separator = { right = "" }, right_padding = 2 },
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = { "branch" },
		lualine_z = { "filetype" },
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = { "branch" },
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
