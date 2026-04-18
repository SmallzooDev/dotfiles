return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      no_italic = true,
      integrations = {
        treesitter = true,
        native_lsp = { enabled = true },
        mason = true,
        which_key = true,
        gitsigns = true,
        neotree = true,
        telescope = { enabled = true },
        blink_cmp = true,
        noice = true,
        lsp_trouble = true,
        aerial = true,
        flash = true,
        render_markdown = true,
        bufferline = true,
        mini = { enabled = true },
      },
      custom_highlights = function(C)
        return {
          -- Floats & popups
          NormalFloat = { bg = "NONE" },
          FloatBorder = { fg = C.overlay0, bg = "NONE" },
          FloatTitle = { bg = "NONE" },
          Pmenu = { bg = "NONE" },

          -- Sidebars & panels
          LazyNormal = { bg = "NONE" },
          MasonNormal = { bg = "NONE" },
          TroubleNormal = { bg = "NONE" },
          TroubleNormalNC = { bg = "NONE" },

          -- Split separator
          WinSeparator = { fg = C.surface0 },
          StatusLine = { bg = C.surface1 },
          StatusLineNC = { fg = C.overlay0, bg = C.surface1 },

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
          WhichKeyBorder = { fg = C.overlay0, bg = "NONE" },
          BlinkCmpMenu = { bg = "NONE" },
          BlinkCmpMenuBorder = { fg = C.overlay0, bg = "NONE" },
          BlinkCmpDoc = { bg = "NONE" },
          BlinkCmpDocBorder = { fg = C.overlay0, bg = "NONE" },
          BlinkCmpSignatureHelp = { bg = "NONE" },
          BlinkCmpSignatureHelpBorder = { fg = C.overlay0, bg = "NONE" },
          SnacksNotifierInfo = { bg = "NONE" },
          SnacksNotifierWarn = { bg = "NONE" },
          SnacksNotifierError = { bg = "NONE" },
          SnacksNotifierDebug = { bg = "NONE" },
          SnacksNotifierTrace = { bg = "NONE" },
          SnacksNotifierBorderInfo = { fg = C.overlay0, bg = "NONE" },
          SnacksNotifierBorderWarn = { fg = C.overlay0, bg = "NONE" },
          SnacksNotifierBorderError = { fg = C.overlay0, bg = "NONE" },
          SnacksNotifierBorderDebug = { fg = C.overlay0, bg = "NONE" },
          SnacksNotifierBorderTrace = { fg = C.overlay0, bg = "NONE" },
        }
      end,
    })

    vim.cmd("colorscheme catppuccin-mocha")

    -- Render-markdown heading colors
    local p = require("catppuccin.palettes").get_palette("mocha")
    local headings = { p.red, p.teal, p.sapphire, p.mauve, p.yellow, p.pink }
    for i, color in ipairs(headings) do
      local val = { fg = color, bold = i <= 3 }
      vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i, val)
      vim.api.nvim_set_hl(0, "@markup.heading." .. i .. ".markdown", val)
    end
  end,
}
