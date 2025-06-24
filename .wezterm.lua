local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Performance optimizations
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.max_fps = 120
config.animation_fps = 60

-- Font settings
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 12

-- Beautiful translucent settings
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.color_scheme = "Catppuccin Mocha"

-- Catppuccin green cursor
config.colors = {
	cursor_bg = "#a6e3a1",
	cursor_border = "#a6e3a1",
	cursor_fg = "#1e1e2e",
}

-- coolnight theme
-- config.colors = {
-- foreground = "#CBE0F0",
-- background = "#011423",
-- cursor_bg = "#47FF9C",
-- cursor_border = "#47FF9C",
-- cursor_fg = "#011423",
-- selection_bg = "#033259",
-- selection_fg = "#CBE0F0",
-- ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }

return config
