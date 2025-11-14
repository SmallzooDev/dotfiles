return {
  "lukas-reineke/headlines.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  ft = { "markdown", "org" },
  config = function()
    require("headlines").setup({
      markdown = {
        bullets = { "󰉫", "󰉬", "󰉭", "󰉮", "󰉯", "󰉰" },
      },
    })
  end,
}
