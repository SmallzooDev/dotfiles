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
    vim.api.nvim_set_hl(0, "NonText", { fg = "#a3a9b5" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#25be6a" })
  end,
}
