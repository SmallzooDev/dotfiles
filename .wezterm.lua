local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 13

config.window_decorations = "RESIZE"

config.colors = {
	foreground = "#deeeed",
	background = "#101010",
	cursor_fg = "#101010",
	cursor_bg = "#deeeed",
	selection_fg = "#101010",
	selection_bg = "#7a7a7a",
	ansi = {
		"#080808", -- black
		"#d70000", -- red
		"#789978", -- green
		"#ffaa88", -- yellow/orange
		"#7788aa", -- blue
		"#d7007d", -- magenta
		"#708090", -- cyan (lack)
		"#deeeed", -- white (luster)
	},
	brights = {
		"#444444", -- bright black
		"#d70000", -- bright red
		"#789978", -- bright green
		"#ffaa88", -- bright yellow/orange
		"#7788aa", -- bright blue
		"#d7007d", -- bright magenta
		"#708090", -- bright cyan
		"#deeeed", -- bright white
	},
}

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32
config.enable_tab_bar = false

config.keys = {
	{ key = "s", mods = "CMD|CTRL", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "CMD|CTRL", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	{ key = "h", mods = "CMD|CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CMD|CTRL", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CMD|CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CMD|CTRL", action = wezterm.action.ActivatePaneDirection("Right") },

	{ key = "h", mods = "CMD|SHIFT|CTRL", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "j", mods = "CMD|SHIFT|CTRL", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
	{ key = "k", mods = "CMD|SHIFT|CTRL", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "l", mods = "CMD|SHIFT|CTRL", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },

	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = "z", mods = "CMD|CTRL", action = wezterm.action.TogglePaneZoomState },
	{ key = "r", mods = "CMD|CTRL", action = wezterm.action.RotatePanes("Clockwise") },

	{
		key = "N",
		mods = "CMD|SHIFT|CTRL",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	{ key = "c", mods = "CMD|CTRL", action = wezterm.action.ActivateCopyMode },
	{ key = "Return", mods = "CMD|CTRL", action = wezterm.action.ShowTabNavigator },
	{ key = "[", mods = "CMD|CTRL", action = wezterm.action.ScrollByPage(-0.5) },
	{ key = "]", mods = "CMD|CTRL", action = wezterm.action.ScrollByPage(0.5) },
}

return config
