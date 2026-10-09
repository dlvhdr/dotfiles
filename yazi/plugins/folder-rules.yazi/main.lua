local function setup()
	ps.sub("ind-sort", function(opt)
		local cwd = cx.active.current.cwd
		if cwd:ends_with("Downloads") or cwd:ends_with("Desktop") or cwd:ends_with("Documents") then
			opt.by, opt.reverse, opt.dir_first = "mtime", true, false
		else
			opt.by, opt.reverse, opt.dir_first = "natural", false, true
		end
		return opt
	end)
end

return { setup = setup }
