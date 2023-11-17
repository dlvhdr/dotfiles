local wezterm = require("wezterm")
local h = require("utils/helpers")
local M = {}

M.get_color_scheme = function()
	return h.is_dark() and "Catppuccin Mocha" or "Catppuccin Latte"
end

wezterm.on("user-var-changed", function(window, _, name, value)
	wezterm.log_info("var", name, value)
	local overrides = window:get_config_overrides() or {}
	if string.match(name, "color_scheme") then
		overrides.color_scheme = value
	end
	window:set_config_overrides(overrides)
end)

return M
