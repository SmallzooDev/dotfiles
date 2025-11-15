return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
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
      "<leader>bd",
      function()
        require("snacks").bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>gg",
      function()
        require("snacks").lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gb",
      function()
        require("snacks").git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<leader>gB",
      function()
        require("snacks").gitbrowse()
      end,
      desc = "Git Browse",
    },
    {
      "]]",
      function()
        require("snacks").words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
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
        -- Setup some globals for debugging
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
