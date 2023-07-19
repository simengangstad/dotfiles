local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

bufferline.setup({
	options = {
		mode = "tabs",
		offsets = {
			{
				filetype = "NvimTree",
				text = "",
				text_align = "center",
				separator = true,
			},
		},
	},
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})
