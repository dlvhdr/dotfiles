-- ~/.config/yazi/init.lua
require("relative-motions"):setup({ show_numbers = "relative_absolute", show_motion = true, enter_mode = "first" })
require("full-border"):setup()

local tokyo_night_theme = require("yatline-tokyo-night"):setup("night") -- or moon/storm/day
require("yatline"):setup({
	theme = tokyo_night_theme,
	show_background = true,

	section_separator = { open = " ", close = " " },
	part_separator = { open = " ", close = " " },
	inverse_separator = { open = " ", close = " " },

	header_line = {
		left = {
			section_a = {
				{ type = "line", custom = false, name = "tabs", params = { "left" } },
			},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {},
			section_b = {},
			section_c = {},
		},
	},

	status_line = {
		left = {
			section_a = {
				{ type = "string", custom = false, name = "tab_mode" },
			},
			section_b = {
				{ type = "string", custom = false, name = "hovered_size" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_path" },
				{ type = "coloreds", custom = false, name = "count" },
			},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "cursor_position" },
				{ type = "coloreds", custom = false, name = "modified-time" },
			},
			section_b = {
				{ type = "string", custom = false, name = "cursor_percentage" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
				{ type = "coloreds", custom = false, name = "permissions" },
				{ type = "coloreds", custom = false, name = "modified-time" },
			},
		},
	},
})

require("yatline-modified-time"):setup()
