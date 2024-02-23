local wezterm = require("wezterm")

local M = {}

M.get_wallpaper = function()
	local wallpapers = {}
	local wallpapers_glob = os.getenv("HOME") .. "/dotfiles/wallpapers/*.{jpg,png,jpeg}"
	for _, v in ipairs(wezterm.glob(wallpapers_glob)) do
		table.insert(wallpapers, v)
	end
	return {
		source = { File = { path = wallpapers[16] } },
		height = "Cover",
		width = "Cover",
		horizontal_align = "Left",
		repeat_x = "Repeat",
		repeat_y = "Repeat",
		opacity = 1,
		-- speed = 200,
	}
end

return M
