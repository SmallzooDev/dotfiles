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
config.window_background_opacity = 0.65
config.macos_window_background_blur = 10

config.window_decorations = "RESIZE"
config.enable_tab_bar = true
-- config.color_scheme = "Catppuccin Mocha"

-- Catppuccin green cursor
-- config.colors = {
-- 	cursor_bg = "#a6e3a1",
-- 	cursor_border = "#a6e3a1",
-- 	cursor_fg = "#1e1e2e",
-- }

-- coolnight theme
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },

	-- Tab bar colors for coolnight theme with transparency
	tab_bar = {
		background = "rgba(1, 20, 35, 0.85)",
		active_tab = {
			bg_color = "#47FF9C",
			fg_color = "#011423",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "rgba(1, 20, 35, 0.85)",
			fg_color = "#5A7C99",
		},
		inactive_tab_hover = {
			bg_color = "#033259",
			fg_color = "#CBE0F0",
		},
		new_tab = {
			bg_color = "rgba(1, 20, 35, 0.85)",
			fg_color = "#5A7C99",
		},
		new_tab_hover = {
			bg_color = "#033259",
			fg_color = "#47FF9C",
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
