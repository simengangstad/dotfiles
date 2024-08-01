local notify_status, notify = pcall(require, "notify")
if not notify_status then
	return
end

notify.setup({
	background_colour = "NotifyBackground",
	fps = 30,
	icons = {
		DEBUG = "",
		ERROR = "",
		INFO = "",
		TRACE = "✎",
		WARN = "",
	},
	level = 2,
	minimum_width = 50,
	render = "wrapped-compact",
	stages = "fade",
	time_formats = {
		notification = "%T",
		notification_history = "%FT%T",
	},
	timeout = 5000,
	top_down = true,
})

vim.notify = notify
