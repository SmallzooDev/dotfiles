return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "work",
        path = "~/kane_wiki",
        overrides = {
          templates = {
            folder = "templates",
          },
        },
      },
      {
        name = "private",
        path = "~/smallzoo",
        overrides = {
          templates = {
            folder = "templates",
          },
        },
      },
    },
    templates = {
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      default_tags = { "daily-notes" },
      template = "daily.md",
    },
  },
  keys = {
    { "<BS>", "<cmd>ObsidianBacklinks<CR>", desc = "Show backlinks", ft = "markdown" },
    { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New note", ft = "markdown" },
    { "<leader>ot", "<cmd>ObsidianTags<CR>", desc = "Search tags", ft = "markdown" },
    { "<leader>b", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch", ft = "markdown" },
    { "<leader>/", "<cmd>ObsidianSearch<CR>", desc = "Search notes", ft = "markdown" },
    { "<leader>td", "<cmd>ObsidianToday<CR>", desc = "Today's note", ft = "markdown" },
    { "<leader>ys", "<cmd>ObsidianYesterday<CR>", desc = "Yesterday's note", ft = "markdown" },
    { "<leader>owc", "<cmd>ObsidianWorkspace<CR>", desc = "Change workspace", ft = "markdown" },
  },
}
