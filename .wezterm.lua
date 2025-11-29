local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Toggle opacity event handler
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
config.enable_tab_bar = true

-- Carbonfox
config.color_scheme = "carbonfox"

config.colors = {
	tab_bar = {
		background = "#161616",
		active_tab = {
			bg_color = "#33b1ff",
			fg_color = "#161616",
		},
		inactive_tab = {
			bg_color = "#262626",
			fg_color = "#f2f4f8",
		},
		inactive_tab_hover = {
			bg_color = "#393939",
			fg_color = "#f2f4f8",
		},
		new_tab = {
			bg_color = "#262626",
			fg_color = "#f2f4f8",
		},
		new_tab_hover = {
			bg_color = "#33b1ff",
			fg_color = "#161616",
		},
	},
}

-- Simple and clean tab bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32

-- Key bindings for splits and navigation
config.keys = {
	{ key = "s", mods = "CMD|CTRL", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "CMD|CTRL", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

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

	-- Copy mode (like tmux copy-mode)
	{ key = "f", mods = "CMD|CTRL", action = wezterm.action.ActivateCopyMode },

	-- Toggle opacity
	{ key = "t", mods = "CMD|CTRL", action = wezterm.action.EmitEvent("toggle-opacity") },
}

return config
