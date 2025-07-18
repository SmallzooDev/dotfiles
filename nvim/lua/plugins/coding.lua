return {
	-- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

	-- vim-surround (matching IdeaVim)
	{
		"tpope/vim-surround",
		event = "VeryLazy",
	},

	-- vim-commentary (matching IdeaVim)
	{
		"tpope/vim-commentary",
		event = "VeryLazy",
	},

	-- Go forward/backward with square brackets
	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost",
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" },
				window = { suffix = "" },
				quickfix = { suffix = "" },
				yank = { suffix = "" },
				treesitter = { suffix = "n" },
			})
		end,
	},

	-- Better increase/descrease
	{
		"monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
					augend.constant.new({ elements = { "let", "const" } }),
				},
			})
		end,
	},

	-- copilot
	{
		"zbirenbaum/copilot.lua",
		enabled = false, -- Disable Copilot entirely to remove inline suggestions
		keys = {
			{
				"<leader>ghc",
				function()
					require("copilot.suggestion").toggle_auto_trigger()
				end,
				desc = "Copilot Toggle Auto Trigger",
			},
		},
		opts = {
			suggestion = {
				auto_trigger = false,
				keymap = {
					accept = "<C-l>",
					accept_word = "<M-l>",
					accept_line = "<M-S-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},
}
