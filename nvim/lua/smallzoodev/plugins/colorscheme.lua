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

    local p = require("nightfox.palette").load("carbonfox")
    local hl = function(name, val)
      vim.api.nvim_set_hl(0, name, val)
    end

    -- Unified popup backgrounds: all floats match editor bg
    hl("NormalFloat", { bg = p.bg1 })
    hl("FloatBorder", { fg = p.bg4, bg = p.bg1 })
    hl("Pmenu", { bg = p.bg1 })
    hl("PmenuSel", { bg = p.sel0, fg = p.fg1, bold = true })
    hl("PmenuSbar", { bg = p.bg2 })
    hl("PmenuThumb", { bg = p.bg4 })

    -- Blink-cmp (completion, docs, signature)
    hl("BlinkCmpMenu", { bg = p.bg1 })
    hl("BlinkCmpMenuBorder", { fg = p.bg4, bg = p.bg1 })
    hl("BlinkCmpDoc", { bg = p.bg1 })
    hl("BlinkCmpDocBorder", { fg = p.bg4, bg = p.bg1 })
    hl("BlinkCmpSignatureHelp", { bg = p.bg1 })
    hl("BlinkCmpSignatureHelpBorder", { fg = p.bg4, bg = p.bg1 })

    -- Which-key
    hl("WhichKeyNormal", { bg = p.bg1 })
    hl("WhichKeyBorder", { fg = p.bg4, bg = p.bg1 })

    -- Lazy.nvim UI
    hl("LazyNormal", { bg = p.bg1 })

    -- Snacks notifications
    hl("SnacksNotifierInfo", { bg = p.bg1 })
    hl("SnacksNotifierWarn", { bg = p.bg1 })
    hl("SnacksNotifierError", { bg = p.bg1 })
    hl("SnacksNotifierDebug", { bg = p.bg1 })
    hl("SnacksNotifierTrace", { bg = p.bg1 })
    hl("SnacksNotifierBorderInfo", { fg = p.bg4, bg = p.bg1 })
    hl("SnacksNotifierBorderWarn", { fg = p.bg4, bg = p.bg1 })
    hl("SnacksNotifierBorderError", { fg = p.bg4, bg = p.bg1 })
    hl("SnacksNotifierBorderDebug", { fg = p.bg4, bg = p.bg1 })
    hl("SnacksNotifierBorderTrace", { fg = p.bg4, bg = p.bg1 })

    -- Other custom highlights
    hl("NonText", { fg = "#a3a9b5" })
    hl("CursorLineNr", { fg = "#25be6a" })

    -- Render-markdown heading colors
    local heading_colors = {
      { fg = p.red.base, bold = true },
      { fg = p.cyan.base, bold = true },
      { fg = p.green.base, bold = true },
      { fg = p.magenta.base },
      { fg = p.blue.base },
      { fg = p.yellow.base },
    }
    for i, c in ipairs(heading_colors) do
      hl("RenderMarkdownH" .. i, c)
      hl("@markup.heading." .. i .. ".markdown", c)
    end
  end,
}
