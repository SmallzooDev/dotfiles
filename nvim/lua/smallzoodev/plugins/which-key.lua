return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      preset = "helix",
      delay = 100,
      icons = {
        rules = false,
      },
      win = {
        border = "single",
        height = { max = 20 },
      },
    })

    wk.add({
      { "<leader>w", group = "Window" },
      { "<leader>x", group = "Trouble" },
      { "<leader>g", group = "Git" },
      { "<leader>f", group = "Find" },
      { "<leader>d", group = "Debug" },
      { "<leader>o", desc = "Toggle outline" },
      { "<leader>O", group = "Obsidian" },
      { "<leader>l", group = "LSP" },
      { "<leader>u", group = "UI" },
      { "<leader>n", group = "Next swap" },
      { "<leader>p", group = "Prev swap" },
      { "<leader>m", group = "Format" },
      { "g", group = "Goto" },
      { "[", group = "Previous" },
      { "]", group = "Next" },
    })
  end,
}
