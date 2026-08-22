return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    image = {
      doc = {
        enabled = true,
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.5),
      },
    },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = true },
    lazygit = {
      configure = false,
      win = { position = "float", width = 0.99, height = 0.99 },
    },
    explorer = { replace_netrw = false },
    picker = {
      prompt = "   ",
      formatters = { file = { filename_first = true } },
      sources = {
        explorer = {
          hidden = true,
          layout = {
            preview = false,
            layout = {
              backdrop = false,
              width = 0.5,
              min_width = 80,
              height = 0.8,
              min_height = 30,
              box = "vertical",
              border = "single",
              { win = "input", height = 1, border = "none" },
              { win = "list", border = "none" },
            },
          },
          jump = { close = true },
        },
      },
    },
    terminal = {
      win = { position = "right", width = 0.5, wo = { winbar = "" } },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("snacks").explorer()
      end,
      desc = "Explorer",
    },
    {
      "<leader>B",
      function()
        require("snacks").bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>gO",
      function()
        require("snacks").gitbrowse()
      end,
      desc = "Open in browser",
    },
    {
      "<leader>lg",
      function()
        require("snacks").lazygit()
      end,
      desc = "LazyGit",
    },
    {
      "]h",
      function()
        require("snacks").words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[h",
      function()
        require("snacks").words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
  },
}
