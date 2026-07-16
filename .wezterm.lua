-- Initialize Configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local opacity = 1
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- Font Configuration
local emoji_font = "Apple Color Emoji"
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrainsMono Nerd Font",
		weight = "Regular",
	},
	emoji_font,
})
config.font_size = 13

-- Color Configuration — two palettes selected by `active_theme`.
-- Palette only; the window background image / opacity below are left alone
-- (theme and background are intentionally isolated).
local active_theme = "coolnight"
local themes = {
	coolnight = {
		foreground = "#CBE0F0",
		background = "#011423",
		cursor_bg = "#47FF9C",
		cursor_fg = "#011423",
		cursor_border = "#47FF9C",
		selection_fg = "#CBE0F0",
		selection_bg = "#033259",
		scrollbar_thumb = "#011423",
		split = "#011423",
		ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
		brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#a277ff", "#a277ff", "#24EAF7", "#24EAF7" },
		indexed = { [16] = "#FFE073", [17] = "#E52E2E" },
	},
	["github-dark"] = {
		foreground = "#e6edf3",
		background = "#0d1117",
		cursor_bg = "#2f81f7",
		cursor_fg = "#0d1117",
		cursor_border = "#2f81f7",
		selection_fg = "#e6edf3",
		selection_bg = "#264f78",
		scrollbar_thumb = "#0d1117",
		split = "#30363d",
		ansi = { "#484f58", "#ff7b72", "#3fb950", "#d29922", "#58a6ff", "#bc8cff", "#39c5cf", "#b1bac4" },
		brights = { "#6e7681", "#ffa198", "#56d364", "#e3b341", "#79c0ff", "#d2a8ff", "#56d4dd", "#ffffff" },
		indexed = { [16] = "#d29922", [17] = "#ff7b72" },
	},
}
config.colors = themes[active_theme]
config.force_reverse_video_cursor = true

-- Window Configuration
config.initial_rows = 45
config.initial_cols = 180
config.window_decorations = "RESIZE"
config.window_background_opacity = opacity
config.window_background_image = wezterm.home_dir .. "/Documents/backgrounds/bg-blurred.png"
config.window_close_confirmation = "NeverPrompt"

-- Performance Settings
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Tab Bar Configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false
config.colors.tab_bar = {
	background = config.window_background_image and "rgba(0, 0, 0, 0)" or transparent_bg,
	new_tab = { fg_color = config.colors.background, bg_color = config.colors.brights[6] },
	new_tab_hover = { fg_color = config.colors.background, bg_color = config.colors.foreground },
}

-- Tab Formatting
wezterm.on("format-tab-title", function(tab, _, _, _, hover)
	local background = config.colors.brights[1]
	local foreground = config.colors.foreground

	if tab.is_active then
		background = config.colors.brights[7]
		foreground = config.colors.background
	elseif hover then
		background = config.colors.brights[8]
		foreground = config.colors.background
	end

	local title = tostring(tab.tab_index + 1)
	return {
		{ Foreground = { Color = background } },
		{ Text = "█" },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Foreground = { Color = background } },
		{ Text = "█" },
	}
end)

-- Default Shell (login shell so .zprofile loads brew PATH etc.)
config.default_prog = { "zsh", "-l" }

-- Keybindings (user customization preserved)
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
