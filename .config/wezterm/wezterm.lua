local k = require("utils/keys")
local w = require("utils/wallpaper")
local b = require("utils/background")
local wezterm = require("wezterm")
local act = wezterm.action

local config = {
	-- general options
	adjust_window_size_when_changing_font_size = false,
	debug_key_events = false,
	enable_tab_bar = false,
	native_macos_fullscreen_mode = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW",
	default_prog = { "/opt/homebrew/bin/fish", "-l" },

	-- font
	font = wezterm.font_with_fallback({
		{ family = "Monaspace Neon" },
		-- { family = "FiraCode Nerd Font Propo" },
	}),
	font_size = 17,

	-- colors
	color_scheme = "tokyonight_night",

	-- background
	background = {
		w.get_wallpaper(),
		b.get_background(0.85),
	},

	-- padding
	window_padding = {
		left = 16,
		right = 8,
		top = 8,
		bottom = 0,
	},

	-- keys
	keys = {
		k.cmd_key("q", k.multiple_actions(":qa!")), -- force quit vim

		k.cmd_to_tmux_prefix("1", "1"), -- first window
		k.cmd_to_tmux_prefix("2", "2"),
		k.cmd_to_tmux_prefix("3", "3"),
		k.cmd_to_tmux_prefix("4", "4"),
		k.cmd_to_tmux_prefix("5", "5"),
		k.cmd_to_tmux_prefix("6", "6"),
		k.cmd_to_tmux_prefix("7", "7"),
		k.cmd_to_tmux_prefix("8", "8"),
		k.cmd_to_tmux_prefix("9", "9"), -- last window

		k.cmd_to_tmux_prefix("'", "'"), -- last session
		k.cmd_to_tmux_prefix(";", ";"), -- last window

		k.cmd_to_tmux_prefix("g", "g"), -- lazygit
		k.cmd_to_tmux_prefix("G", "G"), -- gh-dash
		k.cmd_to_tmux_prefix("M", "M"), -- mprocs
		k.cmd_to_tmux_prefix("e", "|"), -- vertical split
		k.cmd_to_tmux_prefix("E", "-"), -- horizontal split
		k.cmd_to_tmux_prefix("o", "u"), -- open url
		k.cmd_to_tmux_prefix("z", "z"), -- zoom window
		k.cmd_to_tmux_prefix("w", "x"), -- kill window
		k.cmd_to_tmux_prefix("t", "c"), -- new window
		k.cmd_to_tmux_prefix("u", "["), -- new window
		k.cmd_to_tmux_prefix(",", ","), -- open nvim on ~/dotfiles

		-- search up
		{
			mods = "CMD",
			key = "f",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ mods = "CTRL", key = "f" }),
			}),
		},

		-- tmux-fingers (tmux's vimium)
		{
			mods = "CMD|SHIFT",
			key = "f",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "F" }),
			}),
		},

		-- clear shell
		{
			mods = "CMD",
			key = "l",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ mods = "CTRL", key = "l" }),
			}),
		},

		-- t-smart-session-picker
		{
			mods = "CMD",
			key = "k",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "T" }),
			}),
		},

		-- last-prompt
		{
			mods = "CMD|SHIFT",
			key = "c",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "C" }),
			}),
		},

		-- swap window right
		{
			mods = "CMD|SHIFT",
			key = ">",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = ">" }),
			}),
		},

		-- swap window left
		{
			mods = "CMD|SHIFT",
			key = "<",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "<" }),
			}),
		},

		-- vim - select all
		{
			mods = "CMD",
			key = "a",
			action = act.Multiple({
				act.SendKey({ key = "g" }),
				act.SendKey({ key = "g" }),
				act.SendKey({ key = "V" }),
				act.SendKey({ key = "G" }),
			}),
		},

		-- vim - select file
		{
			mods = "CMD",
			key = "p",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "p" }),
			}),
		},

		-- vim - command prompt
		{
			mods = "CMD|SHIFT",
			key = "p",
			action = act.Multiple({
				act.SendKey({ key = " " }),
				act.SendKey({ key = "f" }),
				act.SendKey({ key = "c" }),
			}),
		},

		-- vim - save file
		k.cmd_key(
			"s",
			act.Multiple({
				act.SendKey({ key = "\x1b" }), -- escape
				k.multiple_actions(":w"),
			})
		),
	},
}

return config
