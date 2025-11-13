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
-- config.color_scheme = "Catppuccin Mocha"

-- Overcast theme - EXACT Raycast colors
-- Background: #D8E5EB, Foreground: #0D296D
config.colors = {
	foreground = "#0D296D",
	background = "#D8E5EB",
	cursor_bg = "#6B89C8",
	cursor_border = "#6B89C8",
	cursor_fg = "#FFFFFF",
	selection_bg = "#C5D8ED",
	selection_fg = "#0D296D",

	-- ANSI colors (muted, soft palette)
	ansi = {
		"#4A6798", -- black (non-emphasized)
		"#E07A7A", -- red (soft red)
		"#0D6B2E", -- green (EXTREMELY DARK vivid green)
		"#E8B563", -- yellow (golden)
		"#6B89C8", -- blue (soft blue)
		"#9B7FCE", -- magenta (soft purple)
		"#5FC9D8", -- cyan (soft cyan)
		"#0D296D", -- white (main font)
	},
	brights = {
		"#4A6798", -- bright black (non-emphasized)
		"#E88A8A", -- bright red
		"#1F9A3D", -- bright green (DARK VIVID)
		"#F0C674", -- bright yellow
		"#7B9DD8", -- bright blue
		"#A68FD8", -- bright magenta
		"#6FD9E8", -- bright cyan
		"#0D296D", -- bright white (main font)
	},

	-- Tab bar colors for Overcast theme
	tab_bar = {
		background = "#C5D8ED",
		active_tab = {
			bg_color = "#E8F0F5",
			fg_color = "#0D296D",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#C5D8ED",
			fg_color = "#4A6798",
		},
		inactive_tab_hover = {
			bg_color = "#D8E5EB",
			fg_color = "#0D296D",
		},
		new_tab = {
			bg_color = "#C5D8ED",
			fg_color = "#4A6798",
		},
		new_tab_hover = {
			bg_color = "#D8E5EB",
			fg_color = "#6B89C8",
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
