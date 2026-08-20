local wezterm = require("wezterm")
local config = wezterm.config_builder()
local opacity = 0.80

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

local emoji_font = "Apple Color Emoji"
config.font_dirs = { wezterm.home_dir .. "/Library/Fonts" }
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrainsMono Nerd Font Mono",
		weight = "Regular",
	},
	"Noto Sans Mono CJK KR",
	emoji_font,
})
config.font_size = 12

local themes = dofile(wezterm.home_dir .. "/dotfiles/colorscheme/themes.lua")

local function resolve_theme()
	local ok, stdout = wezterm.run_child_process({ "readlink", wezterm.home_dir .. "/dotfiles/colorscheme/current" })
	local name = ok and stdout:gsub("%s+", "") or ""
	return themes[name] or themes["rose-pine"]
end

local theme = resolve_theme()
if theme.colors then
	config.color_schemes = { [theme.wezterm] = theme.colors }
end
config.color_scheme = theme.wezterm

local scheme = theme.colors or wezterm.color.get_builtin_schemes()[theme.wezterm]
config.force_reverse_video_cursor = true

config.initial_rows = 45
config.initial_cols = 180
config.window_decorations = "RESIZE"
config.window_background_opacity = opacity
config.macos_window_background_blur = 10
config.window_close_confirmation = "NeverPrompt"

config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false
config.colors = {
	tab_bar = {
		background = scheme.background,
		new_tab = { fg_color = scheme.background, bg_color = scheme.brights[6] },
		new_tab_hover = { fg_color = scheme.background, bg_color = scheme.foreground },
	},
}

wezterm.on("format-tab-title", function(tab, _, _, _, hover)
	local background = scheme.brights[1]
	local foreground = scheme.foreground

	if tab.is_active then
		background = scheme.brights[7]
		foreground = scheme.background
	elseif hover then
		background = scheme.brights[8]
		foreground = scheme.background
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

config.default_prog = { wezterm.home_dir .. "/.local/bin/herdr" }

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
