return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Transparent backgrounds
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          NormalDark = { fg = theme.ui.fg_dim, bg = "none" },
          LazyNormal = { bg = "none", fg = theme.ui.fg_dim },
          MasonNormal = { bg = "none", fg = theme.ui.fg_dim },
          -- Tab bar
          TabLine = { bg = "none" },
          TabLineFill = { bg = "none" },
          TabLineSel = { bg = "none" },
          -- Popup menu
          Pmenu = { fg = theme.ui.shade0, bg = "none", blend = vim.o.pumblend },
          PmenuSel = { fg = "none", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = "none" },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          -- Blink.cmp
          BlinkCmpMenu = { bg = "none" },
          BlinkCmpMenuBorder = { bg = "none", fg = theme.ui.bg_p2 },
          BlinkCmpDoc = { bg = "none" },
          BlinkCmpDocBorder = { bg = "none", fg = theme.ui.bg_p2 },
          BlinkCmpSignatureHelp = { bg = "none" },
          BlinkCmpSignatureHelpBorder = { bg = "none", fg = theme.ui.bg_p2 },
          BlinkCmpMenuScrollbar = { bg = "none" },
          BlinkCmpDocScrollbar = { bg = "none" },
          -- Telescope
          TelescopeBorder = { bg = "none", fg = theme.ui.bg_p2 },
          TelescopePromptBorder = { bg = "none", fg = theme.ui.bg_p2 },
          TelescopeResultsBorder = { bg = "none", fg = theme.ui.bg_p2 },
          TelescopePreviewBorder = { bg = "none", fg = theme.ui.bg_p2 },
          TelescopeNormal = { bg = "none" },
          TelescopePromptNormal = { bg = "none" },
          TelescopeResultsNormal = { bg = "none" },
          TelescopePreviewNormal = { bg = "none" },
          TelescopeTitle = { bg = "none", fg = theme.ui.special },
        }
      end,
    })
    vim.cmd.colorscheme("kanagawa")

    -- Kanagawa palette for markdown headings
    local palette = require("kanagawa.colors").setup().palette
    vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = palette.peachRed, bold = true })
    vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = palette.oniViolet, bold = true })
    vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = palette.springGreen, bold = true })
    vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = palette.crystalBlue, bold = true })
    vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = palette.sakuraPink, bold = true })
    vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = palette.springBlue, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = palette.peachRed, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = palette.oniViolet, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = palette.springGreen, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = palette.crystalBlue, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = palette.sakuraPink, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = palette.springBlue, bold = true })
  end,
}
