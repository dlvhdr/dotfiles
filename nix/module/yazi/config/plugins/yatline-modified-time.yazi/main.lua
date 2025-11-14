function hovered()
	local hovered = cx.active.current.hovered
	if hovered then
		return hovered
	else
		return ""
	end
end

local function setup(_, options)
	options = options or {}

	local config = {
		modified_time_color = options.modified_time_color or "silver",
	}

	if Yatline ~= nil then
		function Yatline.coloreds.get:modified_time()
			local h = hovered()
			local modified_time = {}
			local time = ""

			if h or h.cha.mtime then
				time = " M: " .. os.date("%Y-%m-%d %H:%M", h.cha.mtime // 1) .. " "
			end

			table.insert(modified_time, { time, config.modified_time_color })
			return modified_time
		end
	end
end

return { setup = setup }
