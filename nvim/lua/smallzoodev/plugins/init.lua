return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<M-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<M-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<M-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<M-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },
  {
    "paulbkim-dev/vim-herdr-navigation",
    lazy = false,
    dependencies = { "christoomey/vim-tmux-navigator" },
    config = function(plugin)
      dofile(plugin.dir .. "/editor/nvim.lua")
    end,
  },
}
