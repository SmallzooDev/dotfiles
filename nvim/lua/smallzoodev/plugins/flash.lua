return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      search = {
        enabled = true,
      },
      char = {
        enabled = false,
      },
    },
  },
  keys = {
    { "<C-f>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "<C-S-f>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "gr", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "gR", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
