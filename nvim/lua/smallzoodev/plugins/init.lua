return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
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
