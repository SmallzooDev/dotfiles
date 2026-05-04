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
        height = { max = 20 },
      },
    })

    wk.add({
      { "<leader>w", group = "Window", icon = "󰖮" },
      { "<leader>x", group = "Trouble", icon = "󰔫" },
      { "<leader>g", group = "Git", icon = "󰊢" },
      { "<leader>f", group = "Find", icon = "󰈞" },
      { "<leader>o", desc = "Toggle outline", icon = "󰊕" },
      { "<leader>O", group = "Obsidian", icon = "󰠗" },
      { "<leader>l", group = "LSP", icon = "󰒋" },
      { "<leader>u", group = "UI", icon = "󰙵" },
      { "<leader>n", group = "Next swap", icon = "󰒭" },
      { "<leader>p", group = "Prev swap", icon = "󰒮" },
      { "<leader>m", group = "Format", icon = "󰉼" },
      { "g", group = "Goto", icon = "󰁔" },
      { "[", group = "Previous", icon = "󰒫" },
      { "]", group = "Next", icon = "󰒬" },
    })
  end,
}
