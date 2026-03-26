return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  config = function()
    require("rose-pine").setup({
      variant = "main",
      styles = {
        transparency = true,
      },
    })

    vim.cmd("colorscheme rose-pine")

    local hl = function(name, val)
      vim.api.nvim_set_hl(0, name, val)
    end

    local p = {
      base = "#191724",
      surface = "#1f1d2e",
      overlay = "#26233a",
      muted = "#6e6a86",
      subtle = "#908caa",
      text = "#e0def4",
      love = "#eb6f92",
      gold = "#f6c177",
      rose = "#ebbcba",
      pine = "#31748f",
      foam = "#9ccfd8",
      iris = "#c4a7e7",
      highlight_low = "#21202e",
      highlight_med = "#403d52",
      highlight_high = "#524f67",
    }

    -- Unified popup backgrounds: transparent to match editor
    hl("NormalFloat", { bg = "NONE" })
    hl("FloatBorder", { fg = p.muted, bg = "NONE" })
    hl("Pmenu", { bg = "NONE" })
    hl("PmenuSel", { bg = p.overlay, fg = p.text, bold = true })
    hl("PmenuSbar", { bg = p.overlay })
    hl("PmenuThumb", { bg = p.highlight_high })

    -- Blink-cmp (completion, docs, signature)
    hl("BlinkCmpMenu", { bg = "NONE" })
    hl("BlinkCmpMenuBorder", { fg = p.muted, bg = "NONE" })
    hl("BlinkCmpDoc", { bg = "NONE" })
    hl("BlinkCmpDocBorder", { fg = p.muted, bg = "NONE" })
    hl("BlinkCmpSignatureHelp", { bg = "NONE" })
    hl("BlinkCmpSignatureHelpBorder", { fg = p.muted, bg = "NONE" })

    -- Which-key
    hl("WhichKeyNormal", { bg = "NONE" })
    hl("WhichKeyBorder", { fg = p.muted, bg = "NONE" })

    -- Lazy.nvim UI
    hl("LazyNormal", { bg = "NONE" })

    -- Snacks notifications
    hl("SnacksNotifierInfo", { bg = "NONE" })
    hl("SnacksNotifierWarn", { bg = "NONE" })
    hl("SnacksNotifierError", { bg = "NONE" })
    hl("SnacksNotifierDebug", { bg = "NONE" })
    hl("SnacksNotifierTrace", { bg = "NONE" })
    hl("SnacksNotifierBorderInfo", { fg = p.muted, bg = "NONE" })
    hl("SnacksNotifierBorderWarn", { fg = p.muted, bg = "NONE" })
    hl("SnacksNotifierBorderError", { fg = p.muted, bg = "NONE" })
    hl("SnacksNotifierBorderDebug", { fg = p.muted, bg = "NONE" })
    hl("SnacksNotifierBorderTrace", { fg = p.muted, bg = "NONE" })

    -- Other custom highlights
    hl("NonText", { fg = p.subtle })
    hl("CursorLineNr", { fg = p.rose })

    -- Render-markdown heading colors
    local heading_colors = {
      { fg = p.love, bold = true },
      { fg = p.foam, bold = true },
      { fg = p.pine, bold = true },
      { fg = p.iris },
      { fg = p.gold },
      { fg = p.rose },
    }
    for i, c in ipairs(heading_colors) do
      hl("RenderMarkdownH" .. i, c)
      hl("@markup.heading." .. i .. ".markdown", c)
    end
  end,
}
