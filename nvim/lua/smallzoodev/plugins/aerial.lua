return {
  "stevearc/aerial.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = { "AerialToggle", "AerialOpen", "AerialNext", "AerialPrev" },
  opts = {
    backends = { "treesitter", "lsp", "markdown", "man" },
    attach_mode = "global",
    layout = {
      placement = "edge",
      default_direction = "prefer_left",
      min_width = 30,
    },
    show_guides = true,
    guides = {
      mid_item = "├╴",
      last_item = "└╴",
    },
    float = {
      border = "single",
    },
    nav = {
      border = "single",
      preview = true,
    },
  },
  keys = {
    { "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
    { "]a", "<cmd>AerialNext<CR>", desc = "Next symbol (aerial)" },
    { "[a", "<cmd>AerialPrev<CR>", desc = "Prev symbol (aerial)" },
  },
}
