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

    -- Render-markdown heading colors from carbonfox palette
    local p = require("nightfox.palette").load("carbonfox")
    local heading_colors = {
      { fg = p.red.base, bold = true },
      { fg = p.cyan.base, bold = true },
      { fg = p.green.base, bold = true },
      { fg = p.magenta.base },
      { fg = p.blue.base },
      { fg = p.yellow.base },
    }
    for i, hl in ipairs(heading_colors) do
      vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i, hl)
      vim.api.nvim_set_hl(0, "@markup.heading." .. i .. ".markdown", hl)
    end
  end,
}
