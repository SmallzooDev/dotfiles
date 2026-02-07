return {
  "EdenEast/nightfox.nvim",
  priority = 1000,
  config = function()
    require("nightfox").setup({
      options = {
        transparent = false,
        terminal_colors = true,
        styles = {},
      },
    })

    vim.cmd("colorscheme carbonfox")
  end,
}
