return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  config = function()
    require("rose-pine").setup({
      variant = "moon",
      styles = {
        transparency = true,
      },
      highlight_groups = {
        -- Floats & popups
        NormalFloat = { bg = "NONE" },
        FloatBorder = { fg = "muted", bg = "NONE" },
        FloatTitle = { bg = "NONE" },
        Pmenu = { bg = "NONE" },

        -- Sidebars & panels
        NormalDark = { bg = "NONE" },
        LazyNormal = { bg = "NONE" },
        MasonNormal = { bg = "NONE" },
        TroubleNormal = { bg = "NONE" },
        TroubleNormalNC = { bg = "NONE" },

        -- Gutter
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

        -- Plugin floats
        WhichKeyNormal = { bg = "NONE" },
        WhichKeyBorder = { fg = "muted", bg = "NONE" },
        BlinkCmpMenu = { bg = "NONE" },
        BlinkCmpMenuBorder = { fg = "muted", bg = "NONE" },
        BlinkCmpDoc = { bg = "NONE" },
        BlinkCmpDocBorder = { fg = "muted", bg = "NONE" },
        BlinkCmpSignatureHelp = { bg = "NONE" },
        BlinkCmpSignatureHelpBorder = { fg = "muted", bg = "NONE" },
        SnacksNotifierInfo = { bg = "NONE" },
        SnacksNotifierWarn = { bg = "NONE" },
        SnacksNotifierError = { bg = "NONE" },
        SnacksNotifierDebug = { bg = "NONE" },
        SnacksNotifierTrace = { bg = "NONE" },
        SnacksNotifierBorderInfo = { fg = "muted", bg = "NONE" },
        SnacksNotifierBorderWarn = { fg = "muted", bg = "NONE" },
        SnacksNotifierBorderError = { fg = "muted", bg = "NONE" },
        SnacksNotifierBorderDebug = { fg = "muted", bg = "NONE" },
        SnacksNotifierBorderTrace = { fg = "muted", bg = "NONE" },
      },
    })

    vim.cmd("colorscheme rose-pine-moon")

    -- Render-markdown heading colors
    local p = require("rose-pine.palette")
    local headings = { p.love, p.foam, p.pine, p.iris, p.gold, p.rose }
    for i, color in ipairs(headings) do
      local val = { fg = color, bold = i <= 3 }
      vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i, val)
      vim.api.nvim_set_hl(0, "@markup.heading." .. i .. ".markdown", val)
    end
  end,
}
