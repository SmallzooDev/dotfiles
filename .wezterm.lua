local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Performance optimizations
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.max_fps = 120
config.animation_fps = 60

-- Font settings
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 13

-- Beautiful translucent settings
-- config.window_background_opacity = 0.80
-- config.macos_window_background_blur = 10

config.window_decorations = "RESIZE"
config.enable_tab_bar = true

-- Material Deep Ocean (matching Neovim)
config.colors = {
	foreground = "#e8eef5",
	background = "#0f111a",
	cursor_bg = "#89ddff",
	cursor_border = "#89ddff",
	cursor_fg = "#0f111a",
	selection_bg = "#1f2335",
	selection_fg = "#eeffff",

	ansi = {
		"#1b1e28", -- black
		"#f07178", -- red
		"#c3e88d", -- green
		"#ffcb6b", -- yellow
		"#82aaff", -- blue
		"#c792ea", -- magenta
		"#89ddff", -- cyan
		"#eeffff", -- white
	},
	brights = {
		"#b0bac5", -- bright black
		"#f07178", -- bright red
		"#c3e88d", -- bright green
		"#ffcb6b", -- bright yellow
		"#82aaff", -- bright blue
		"#c792ea", -- bright magenta
		"#89ddff", -- bright cyan
		"#eeffff", -- bright white
	},

	tab_bar = {
		background = "#0f111a",
		active_tab = {
			bg_color = "#1f2335",
			fg_color = "#89ddff",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#1a1e2e",
			fg_color = "#b0bac5",
		},
		inactive_tab_hover = {
			bg_color = "#1f2335",
			fg_color = "#89ddff",
		},
		new_tab = {
			bg_color = "#1a1e2e",
			fg_color = "#b0bac5",
		},
		new_tab_hover = {
			bg_color = "#1f2335",
			fg_color = "#89ddff",
		},
	},
}

-- Simple and clean tab bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32

-- Key bindings for splits and navigation
config.keys = {
	-- Split panes
	{ key = "h", mods = "CMD|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Navigate between panes (vim-style with CMD)
	{ key = "h", mods = "CMD|CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CMD|CTRL", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CMD|CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CMD|CTRL", action = wezterm.action.ActivatePaneDirection("Right") },

	-- Navigate with arrow keys
	{ key = "LeftArrow", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "DownArrow", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "UpArrow", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "RightArrow", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Right") },

	-- Resize panes
	{ key = "h", mods = "CMD|SHIFT|CTRL", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "j", mods = "CMD|SHIFT|CTRL", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
	{ key = "k", mods = "CMD|SHIFT|CTRL", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "l", mods = "CMD|SHIFT|CTRL", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },

	-- Close pane
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

	-- Toggle pane zoom
	{ key = "z", mods = "CMD|CTRL", action = wezterm.action.TogglePaneZoomState },

	-- Rotate panes
	{ key = "r", mods = "CMD|CTRL", action = wezterm.action.RotatePanes("Clockwise") },

	-- Rename tab
	{
		key = "R",
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
}

return config
