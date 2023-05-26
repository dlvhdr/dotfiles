local terminalBundleID = "net.kovidgoyal.kitty"

local function moveWindowsToDesktop2()
	local windows = hs.window.allWindows()

	local terminalWindow = hs.application.get(terminalBundleID):mainWindow()
	local primaryScreen = hs.screen.primaryScreen()
	local spaces = hs.spaces.spacesForScreen(primaryScreen)

	local desktop2ID = spaces[2]

	for _, window in ipairs(windows) do
		if window ~= terminalWindow then
			hs.spaces.moveWindowToSpace(window, desktop2ID)
		end
	end
end

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "M", moveWindowsToDesktop2)
