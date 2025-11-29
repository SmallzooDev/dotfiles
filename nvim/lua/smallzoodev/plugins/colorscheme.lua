return {
  "EdenEast/nightfox.nvim",
  priority = 1000,
  config = function()
    require("nightfox").setup({
      options = {
        transparent = true,
      },
      groups = {
        all = {
          NormalFloat = { bg = "NONE", fg = "#f2f4f8" },
          FloatBorder = { bg = "NONE", fg = "#f2f4f8" },
          FloatTitle = { bg = "NONE", fg = "#f2f4f8" },
          TabLine = { bg = "NONE" },
          TabLineFill = { bg = "NONE" },
          TabLineSel = { bg = "NONE" },
          Pmenu = { bg = "NONE", fg = "#f2f4f8" },
          PmenuSbar = { bg = "NONE", fg = "#f2f4f8" },
          PmenuThumb = { bg = "#f2f4f8", fg = "#f2f4f8" },
          CmpNormal = { bg = "NONE" },
          CmpDoc = { bg = "NONE" },
          CmpDocBorder = { bg = "NONE", fg = "#f2f4f8" },
          BlinkCmpMenu = { bg = "NONE" },
          BlinkCmpMenuBorder = { bg = "NONE", fg = "#f2f4f8" },
          BlinkCmpDoc = { bg = "NONE" },
          BlinkCmpDocBorder = { bg = "NONE", fg = "#f2f4f8" },
          BlinkCmpSignatureHelp = { bg = "NONE" },
          BlinkCmpSignatureHelpBorder = { bg = "NONE", fg = "#f2f4f8" },
          BlinkCmpMenuScrollbar = { bg = "NONE", fg = "#f2f4f8" },
          BlinkCmpDocScrollbar = { bg = "NONE", fg = "#f2f4f8" },
          -- Telescope
          TelescopeBorder = { bg = "NONE", fg = "#f2f4f8" },
          TelescopePromptBorder = { bg = "NONE", fg = "#f2f4f8" },
          TelescopeResultsBorder = { bg = "NONE", fg = "#f2f4f8" },
          TelescopePreviewBorder = { bg = "NONE", fg = "#f2f4f8" },
          TelescopeNormal = { bg = "NONE", fg = "#f2f4f8" },
          TelescopePromptNormal = { bg = "NONE", fg = "#f2f4f8" },
          TelescopeResultsNormal = { bg = "NONE", fg = "#f2f4f8" },
          TelescopePreviewNormal = { bg = "NONE", fg = "#f2f4f8" },
          TelescopeTitle = { bg = "NONE", fg = "#f2f4f8" },
        },
      },
    })
    vim.cmd.colorscheme("carbonfox")
  end,
}
