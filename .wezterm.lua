local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Kanagawa color palette
local kanagawa = {
	sumiInk0 = "#16161D",
	sumiInk1 = "#1F1F28",
	sumiInk2 = "#2A2A37",
	sumiInk3 = "#363646",
	sumiInk4 = "#54546D",
	fujiWhite = "#DCD7BA",
	oldWhite = "#C8C093",
	crystalBlue = "#7E9CD8",
	springBlue = "#7FB4CA",
	springGreen = "#98BB6C",
	oniViolet = "#957FB8",
	sakuraPink = "#D27E99",
	peachRed = "#FF5D62",
	surimiOrange = "#FFA066",
	carpYellow = "#E6C384",
	waveAqua2 = "#7AA89F",
}

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
config.enable_tab_bar = false

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 13

config.window_background_opacity = 0.80
config.macos_window_background_blur = 10

config.window_decorations = "RESIZE"

-- Kanagawa
config.color_scheme = "Kanagawa (Gogh)"

config.colors = {
	tab_bar = {
		background = kanagawa.sumiInk0,
		active_tab = {
			bg_color = kanagawa.crystalBlue,
			fg_color = kanagawa.sumiInk0,
		},
		inactive_tab = {
			bg_color = kanagawa.sumiInk2,
			fg_color = kanagawa.fujiWhite,
		},
		inactive_tab_hover = {
			bg_color = kanagawa.sumiInk3,
			fg_color = kanagawa.fujiWhite,
		},
		new_tab = {
			bg_color = kanagawa.sumiInk2,
			fg_color = kanagawa.fujiWhite,
		},
		new_tab_hover = {
			bg_color = kanagawa.crystalBlue,
			fg_color = kanagawa.sumiInk0,
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
	{ key = "v", mods = "CMD|CTRL", action = wezterm.action.ActivateCopyMode },

	-- Toggle opacity
	{ key = "t", mods = "CMD|CTRL", action = wezterm.action.EmitEvent("toggle-opacity") },

	-- Show tab navigator
	{ key = "Return", mods = "CMD|CTRL", action = wezterm.action.ShowTabNavigator },

	-- Quick select
	{ key = "f", mods = "CMD|CTRL", action = wezterm.action.QuickSelect },

	-- Scroll
	{ key = "[", mods = "CMD|CTRL", action = wezterm.action.ScrollByPage(-0.5) },
	{ key = "]", mods = "CMD|CTRL", action = wezterm.action.ScrollByPage(0.5) },
}

return config
