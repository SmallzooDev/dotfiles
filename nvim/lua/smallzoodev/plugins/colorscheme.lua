return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      transparent = true,
      theme = "wave",
      overrides = function(colors)
        local none = { bg = "NONE" }
        return {
          -- Floats & popups
          NormalFloat = none,
          FloatBorder = { fg = colors.theme.ui.nontext, bg = "NONE" },
          FloatTitle = none,
          Pmenu = none,

          -- Sidebars & panels
          NormalDark = none,
          LazyNormal = none,
          MasonNormal = none,
          TroubleNormal = none,
          TroubleNormalNC = none,

          -- Gutter
          SignColumn = none,
          LineNr = none,
          CursorLineSign = none,
          FoldColumn = none,
          DiagnosticSignError = none,
          DiagnosticSignWarn = none,
          DiagnosticSignInfo = none,
          DiagnosticSignHint = none,
          GitSignsAdd = none,
          GitSignsChange = none,
          GitSignsDelete = none,

          -- Plugin floats
          WhichKeyNormal = none,
          WhichKeyBorder = { fg = colors.theme.ui.nontext, bg = "NONE" },
          BlinkCmpMenu = none,
          BlinkCmpMenuBorder = { fg = colors.theme.ui.nontext, bg = "NONE" },
          BlinkCmpDoc = none,
          BlinkCmpDocBorder = { fg = colors.theme.ui.nontext, bg = "NONE" },
          BlinkCmpSignatureHelp = none,
          BlinkCmpSignatureHelpBorder = { fg = colors.theme.ui.nontext, bg = "NONE" },
          SnacksNotifierInfo = none,
          SnacksNotifierWarn = none,
          SnacksNotifierError = none,
          SnacksNotifierDebug = none,
          SnacksNotifierTrace = none,
          SnacksNotifierBorderInfo = { fg = colors.theme.ui.nontext, bg = "NONE" },
          SnacksNotifierBorderWarn = { fg = colors.theme.ui.nontext, bg = "NONE" },
          SnacksNotifierBorderError = { fg = colors.theme.ui.nontext, bg = "NONE" },
          SnacksNotifierBorderDebug = { fg = colors.theme.ui.nontext, bg = "NONE" },
          SnacksNotifierBorderTrace = { fg = colors.theme.ui.nontext, bg = "NONE" },
        }
      end,
    })

    vim.cmd("colorscheme kanagawa-wave")

    -- Render-markdown heading colors
    local p = require("kanagawa.colors").setup({ theme = "wave" }).palette
    local headings = { p.peachRed, p.springBlue, p.springGreen, p.oniViolet, p.crystalBlue, p.carpYellow }
    for i, color in ipairs(headings) do
      local val = { fg = color, bold = i <= 3 }
      vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i, val)
      vim.api.nvim_set_hl(0, "@markup.heading." .. i .. ".markdown", val)
    end
  end,
}
