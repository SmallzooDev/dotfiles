return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    backends = { "treesitter", "lsp", "markdown", "man" },
    layout = {
      default_direction = "prefer_right",
      min_width = 30,
      max_width = { 40, 0.2 },
    },
    show_guides = true,
    guides = {
      mid_item = "├╴",
      last_item = "└╴",
      nested_top = "│ ",
      whitespace = "  ",
    },
    filter_kind = {
      "Class",
      "Constructor",
      "Enum",
      "Function",
      "Interface",
      "Module",
      "Method",
      "Struct",
    },
    highlight_on_jump = 300,
    autojump = false,
    close_on_select = false,
    post_jump_cmd = "normal! zz",
    lazy_load = true,
    float = {
      border = "rounded",
      relative = "cursor",
    },
    nav = {
      border = "rounded",
      preview = true,
    },
  },
  keys = {
    { "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
    { "]a", "<cmd>AerialNext<CR>", desc = "Next symbol (aerial)" },
    { "[a", "<cmd>AerialPrev<CR>", desc = "Prev symbol (aerial)" },
  },
}
