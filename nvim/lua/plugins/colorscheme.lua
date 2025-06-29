return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		local transparent = true

		local bg = "#011628"
		local bg_dark = "#011423"
		local bg_highlight = "#143652"
		local bg_search = "#0A64AC"
		local bg_visual = "#275378"
		local fg = "#CBE0F0"
		local fg_dark = "#B4D0E9"
		local fg_gutter = "#627E97"
		local border = "#547998"

		require("tokyonight").setup({
			style = "night",
			transparent = transparent,
			styles = {
				sidebars = transparent and "transparent" or "dark",
				floats = transparent and "transparent" or "dark",
			},
			on_colors = function(colors)
				colors.bg = bg
				colors.bg_dark = transparent and colors.none or bg_dark
				colors.bg_float = transparent and colors.none or bg_dark
				colors.bg_highlight = bg_highlight
				colors.bg_popup = bg_dark
				colors.bg_search = bg_search
				colors.bg_sidebar = transparent and colors.none or bg_dark
				colors.bg_statusline = transparent and colors.none or bg_dark
				colors.bg_visual = bg_visual
				colors.border = border
				colors.fg = fg
				colors.fg_dark = fg_dark
				colors.fg_float = fg
				colors.fg_gutter = fg_gutter
				colors.fg_sidebar = fg_dark

				-- Override all syntax colors to match coolnight
				colors.blue = "#0FC5ED"
				colors.cyan = "#24EAF7"
				colors.green = "#44FFB1"
				colors.magenta = "#A277FF"
				colors.purple = "#A277FF"
				-- colors.red = "#E52E2E"
				colors.yellow = "#FFE073"
				colors.orange = "#FFE073"
				colors.teal = "#24EAF7"

				-- Override git colors
				colors.git = {
					add = "#44FFB1",
					change = "#0FC5ED",
					delete = "#E52E2E",
				}

				-- Override diagnostic colors
				colors.error = "#E52E2E"
				colors.warning = "#FFE073"
				colors.info = "#0FC5ED"
				colors.hint = "#24EAF7"

				-- Override diff colors
				colors.diff = {
					add = "#44FFB1",
					delete = "#E52E2E",
					change = "#0FC5ED",
					text = "#FFE073",
				}
			end,
		})

		vim.cmd("colorscheme tokyonight")
	end,
}

