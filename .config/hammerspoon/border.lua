local wb = hs.canvas.windowBehaviors
local spaces = require("hs._asm.undocumented.spaces")
local running = require("running")

hs.window.filter.forceRefreshOnSpaceChange = true

local module = { widget = hs.canvas.new({}) }

local desktop = require("desktop")

module.widget:level(hs.canvas.windowLevels.floating)
module.widget:clickActivating(false)
module.widget:_accessibilitySubrole("AXUnknown")
module.widget:behavior({ wb.default, wb.transient })

local function drawBorderAroundWindow(win)
	if win == nil or win:subrole() ~= "AXStandardWindow" or not win:isVisible() or win:isFullScreen() then
		return
	end

	local top_left = win:topLeft()
	local size = win:size()

	print(size["h"], size["w"])
	if size["h"] ~= nil and size["h"] > 1000 and size["w"] ~= nil and size["w"] > 1800 then
		print("Not drawing border on full width/height window")
		return
	end

	module.widget:frame(hs.screen.mainScreen():fullFrame())

	local radius = 10
	local border = 2
	local offset = 2
	local alpha = 0.8

	module.widget
		:replaceElements({
			-- first we start with a rectangle that covers the full canvas
			action = "build",
			frame = {
				x = top_left["x"] - offset,
				y = top_left["y"] - offset,
				h = size["h"] + offset * 2,
				w = size["w"] + offset * 2,
			},
			-- padding = 0,
			type = "rectangle",
			roundedRectRadii = { xRadius = radius, yRadius = radius },
			withShadow = false,
		}, {
			-- first we start with a rectangle that covers the full canvas
			action = "fill",
			frame = {
				x = top_left["x"] + border - offset,
				y = top_left["y"] + border - offset,
				h = size["h"] - border * 2 + offset * 2,
				w = size["w"] - border * 2 + offset * 2,
			},
			-- padding = 0,
			type = "rectangle",
			reversePath = true,
			roundedRectRadii = { xRadius = radius - border, yRadius = radius - border },
			withShadow = false,
			fillColor = { alpha = alpha, red = 196 / 255, green = 165 / 255, blue = 227 / 255 },
		})
		:show()
end

module.update = function()
	module.widget:hide()

	local win = hs.window.focusedWindow()
	if win == nil or not win:application() or not win:application():isRunning() or not win:isVisible() then
		return
	end
	local current = spaces.activeSpace()
	local found = false
	for _, space in ipairs(win:spaces()) do
		if space == current then
			found = true
		end
	end
	if not found then
		win = nil
	end

	drawBorderAroundWindow(win)
end

running.onChange(function(_app, _win, _event)
	module.update()
end)

local watcher = hs.spaces.watcher.new(module.update)
watcher:start()
desktop.onChange(module.update)

module.update()

return module
