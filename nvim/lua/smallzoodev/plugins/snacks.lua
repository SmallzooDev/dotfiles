return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = {
    {
      "nvim-mini/mini.icons",
      lazy = true,
      config = function()
        require("mini.icons").setup()
        require("mini.icons").mock_nvim_web_devicons()
      end,
    },
  },
  opts = {
    bigfile = { enabled = true },
    image = {
      doc = {
        enabled = true,
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.5),
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    lazygit = {
      configure = false,
      win = { position = "float", width = 0.99, height = 0.99 },
    },
    picker = {
      prompt = "   ",
      formatters = { file = { filename_first = true } },
    },
    terminal = {
      win = { position = "right", width = 0.5, wo = { winbar = "" } },
    },
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
  },
  keys = {
    {
      "<leader>un",
      function()
        require("snacks").notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "<leader>uh",
      function()
        require("snacks").notifier.show_history()
      end,
      desc = "Notification History",
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
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...)
          require("snacks").debug.inspect(...)
        end
        _G.bt = function()
          require("snacks").debug.backtrace()
        end
        vim.print = _G.dd
      end,
    })
  end,
}
