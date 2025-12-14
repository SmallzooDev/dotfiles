local wezterm = require("wezterm")

local config = wezterm.config_builder()

wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 1.0
	else
		if overrides.window_background_opacity == 0.80 then
			overrides.window_background_opacity = 1.0
		else
			overrides.window_background_opacity = 0.80
		end
	end
	window:set_config_overrides(overrides)
end)

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.max_fps = 120
config.animation_fps = 60

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 13

config.window_background_opacity = 0.80
config.macos_window_background_blur = 10

config.window_decorations = "RESIZE"

config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	split = "#547998",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
	tab_bar = {
		background = "#011423",
		active_tab = {
			bg_color = "#0FC5ED",
			fg_color = "#011423",
		},
		inactive_tab = {
			bg_color = "#011628",
			fg_color = "#627E97",
		},
		inactive_tab_hover = {
			bg_color = "#143652",
			fg_color = "#CBE0F0",
		},
		new_tab = {
			bg_color = "#011628",
			fg_color = "#627E97",
		},
		new_tab_hover = {
			bg_color = "#0FC5ED",
			fg_color = "#011423",
		},
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

	{ key = "LeftArrow", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "DownArrow", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "UpArrow", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "RightArrow", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Right") },

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
	{ key = "t", mods = "CMD|CTRL", action = wezterm.action.EmitEvent("toggle-opacity") },
	{ key = "Return", mods = "CMD|CTRL", action = wezterm.action.ShowTabNavigator },
	{ key = "f", mods = "CMD|CTRL", action = wezterm.action.QuickSelect },
	{ key = "[", mods = "CMD|CTRL", action = wezterm.action.ScrollByPage(-0.5) },
	{ key = "]", mods = "CMD|CTRL", action = wezterm.action.ScrollByPage(0.5) },
}

return config
