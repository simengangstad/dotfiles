local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	height = 35,
	color = colors.bar.bg,
	padding_right = 2,
	padding_left = 2,
	shadow = true,
	corner_radius = 10,
	margin = 5,
	y_offset = 5,
})
