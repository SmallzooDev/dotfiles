-- Plugins: Colorschemes
-- https://github.com/smallzooDev/vim-config

return {

	-- Use last-used colorscheme
	{
		'smallzooDev/theme-loader.nvim',
		lazy = false,
		priority = 99,
		opts = { initial_colorscheme = 'neohybrid' },
	},

	{ 'smallzooDev/neo-hybrid.vim', priority = 100, lazy = false },
	{ 'smallzooDev/awesome-vim-colorschemes', lazy = false },

}
