local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 13
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.5
config.macos_window_background_blur = 16
config.enable_tab_bar = false
-- config.colors = {
--foreground = "#CBE0F0",
--background = "#011423",
--cursor_bg = "#47FF9C",
--cursor_border = "#47FF9C",
--cursor_fg = "#011423",
--selection_bg = "#033259",
--selection_fg = "#CBE0F0",
--ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
--brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
--}
--

config.color_scheme = "Github Dark"
return config
