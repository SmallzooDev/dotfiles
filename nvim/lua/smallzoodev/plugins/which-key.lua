return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      preset = "helix",
      delay = 300,
      win = {
        border = "rounded",
      },
    })

    wk.add({
      { "<leader>w", group = "Window" },
      { "<leader>x", group = "Trouble" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Hunk" },
      { "<leader>o", group = "Obsidian" },
      { "<leader>l", group = "LSP" },
      { "<leader>u", group = "UI" },
      { "<leader>c", group = "Code" },
      { "<leader>v", group = "Vsplit +" },
      { "<leader>n", group = "Next swap" },
      { "<leader>p", group = "Prev swap" },
      { "<leader>m", group = "Format" },
      { "g", group = "Goto" },
      { "[", group = "Previous" },
      { "]", group = "Next" },
    })
  end,
}
