local focus = require("slack.focus")

local function slackUp()
	hs.eventtap.keyStroke({}, "up", 0)
end

local function slackDown()
	hs.eventtap.keyStroke({}, "down", 0)
end

local function startSlackReminder()
	focus.mainMessageBox()

	hs.timer.doAfter(0.3, function()
		hs.eventtap.keyStrokes("/remind me at ")
	end)
end

local function openSlackThread()
	focus.mainMessageBox()

	hs.timer.doAfter(0.1, function()
		slackUp()
		hs.eventtap.keyStroke({}, "t", 0)
		focus.threadMessageBox(true)
	end)
end

slackModal = hs.hotkey.modal.new()

slackModal:bind({ "ctrl" }, "h", nil, focus.mainMessageBox, nil, focus.mainMessageBox)
slackModal:bind({ "ctrl" }, "n", nil, slackDown, nil, slackDown)
slackModal:bind({ "ctrl" }, "p", nil, slackUp, nil, slackUp)
slackModal:bind({ "ctrl" }, "l", nil, focus.threadMessageBox, nil, focus.threadMessageBox)
slackModal:bind({ "ctrl" }, "r", nil, startSlackReminder, nil, startSlackReminder)
slackModal:bind({ "ctrl" }, "t", nil, openSlackThread, nil, openSlackThread)
slackModal:bind({ "shift", "cmd" }, "delete", nil, focus.leaveChannel, nil, nil)

slackWatcher = hs.application.watcher.new(function(applicationName, eventType)
	if applicationName ~= "Slack" then
		return
	end

	if eventType == hs.application.watcher.activated then
		slackModal:enter()
	elseif eventType == hs.application.watcher.deactivated then
		slackModal:exit()
	end
end)

slackWatcher:start()
