return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		priority = 1000,
		opts = {
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			transparent_background = true,
			term_colors = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				telescope = true,
				notify = true,
				mini = true,
			},
			custom_highlights = function(colors)
				return {
					LspInlayHint = { bg = colors.surface0, fg = colors.subtext0 },
				}
			end,
		},
	},
}
