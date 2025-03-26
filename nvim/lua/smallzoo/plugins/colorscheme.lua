-- Plugins: Colorschemes
-- https://github.com/smallzoo/vim-config

return {

	-- Use last-used colorscheme
	{
		'smallzoo/theme-loader.nvim',
		lazy = false,
		priority = 99,
		opts = { initial_colorscheme = 'neohybrid' },
	},

	{ 'smallzoo/neo-hybrid.vim', priority = 100, lazy = false },
	{ 'smallzoo/awesome-vim-colorschemes', lazy = false },

}
