return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      transparent = true,
      theme = "wave",
      overrides = function(colors)
        local t = colors.theme
        return {
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
          FloatTitle = { bg = "NONE" },
          NormalDark = { bg = "NONE" },
          LazyNormal = { bg = "NONE" },
          MasonNormal = { bg = "NONE" },
          Pmenu = { bg = "NONE" },
          TroubleNormal = { bg = "NONE" },
          TroubleNormalNC = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
          LineNr = { bg = "NONE" },
          CursorLineSign = { bg = "NONE" },
          FoldColumn = { bg = "NONE" },
          DiagnosticSignError = { bg = "NONE" },
          DiagnosticSignWarn = { bg = "NONE" },
          DiagnosticSignInfo = { bg = "NONE" },
          DiagnosticSignHint = { bg = "NONE" },
          GitSignsAdd = { bg = "NONE" },
          GitSignsChange = { bg = "NONE" },
          GitSignsDelete = { bg = "NONE" },
        }
      end,
    })

    vim.cmd("colorscheme kanagawa-wave")

    local hl = function(name, val)
      vim.api.nvim_set_hl(0, name, val)
    end

    local p = {
      sumiInk1 = "#1F1F28",
      sumiInk2 = "#2A2A37",
      sumiInk3 = "#363646",
      sumiInk4 = "#54546D",
      fujiGray = "#727169",
      fujiWhite = "#DCD7BA",
      peachRed = "#FF5D62",
      carpYellow = "#E6C384",
      springGreen = "#98BB6C",
      springBlue = "#7FB4CA",
      crystalBlue = "#7E9CD8",
      oniViolet = "#957FB8",
      sakuraPink = "#D27E99",
      waveBlue2 = "#2D4F67",
    }

    -- Unified popup backgrounds: transparent to match editor
    hl("NormalFloat", { bg = "NONE" })
    hl("FloatBorder", { fg = p.sumiInk4, bg = "NONE" })
    hl("Pmenu", { bg = "NONE" })
    hl("PmenuSel", { bg = p.sumiInk3, fg = p.fujiWhite, bold = true })
    hl("PmenuSbar", { bg = p.sumiInk3 })
    hl("PmenuThumb", { bg = p.sumiInk4 })

    -- Blink-cmp (completion, docs, signature)
    hl("BlinkCmpMenu", { bg = "NONE" })
    hl("BlinkCmpMenuBorder", { fg = p.sumiInk4, bg = "NONE" })
    hl("BlinkCmpDoc", { bg = "NONE" })
    hl("BlinkCmpDocBorder", { fg = p.sumiInk4, bg = "NONE" })
    hl("BlinkCmpSignatureHelp", { bg = "NONE" })
    hl("BlinkCmpSignatureHelpBorder", { fg = p.sumiInk4, bg = "NONE" })

    -- Which-key
    hl("WhichKeyNormal", { bg = "NONE" })
    hl("WhichKeyBorder", { fg = p.sumiInk4, bg = "NONE" })

    -- Lazy.nvim UI
    hl("LazyNormal", { bg = "NONE" })

    -- Snacks notifications
    hl("SnacksNotifierInfo", { bg = "NONE" })
    hl("SnacksNotifierWarn", { bg = "NONE" })
    hl("SnacksNotifierError", { bg = "NONE" })
    hl("SnacksNotifierDebug", { bg = "NONE" })
    hl("SnacksNotifierTrace", { bg = "NONE" })
    hl("SnacksNotifierBorderInfo", { fg = p.sumiInk4, bg = "NONE" })
    hl("SnacksNotifierBorderWarn", { fg = p.sumiInk4, bg = "NONE" })
    hl("SnacksNotifierBorderError", { fg = p.sumiInk4, bg = "NONE" })
    hl("SnacksNotifierBorderDebug", { fg = p.sumiInk4, bg = "NONE" })
    hl("SnacksNotifierBorderTrace", { fg = p.sumiInk4, bg = "NONE" })

    -- Other custom highlights
    hl("NonText", { fg = p.fujiGray })
    hl("CursorLineNr", { fg = p.springGreen })

    -- Render-markdown heading colors
    local heading_colors = {
      { fg = p.peachRed, bold = true },
      { fg = p.springBlue, bold = true },
      { fg = p.springGreen, bold = true },
      { fg = p.oniViolet },
      { fg = p.crystalBlue },
      { fg = p.carpYellow },
    }
    for i, c in ipairs(heading_colors) do
      hl("RenderMarkdownH" .. i, c)
      hl("@markup.heading." .. i .. ".markdown", c)
    end
  end,
}
