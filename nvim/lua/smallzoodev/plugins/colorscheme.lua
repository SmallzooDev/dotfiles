return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      sidebars = { "qf", "help" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
      on_colors = function(colors)
        -- Keep default Tokyo Night colors
      end,
      on_highlights = function(hl, colors)
        -- Custom LSP reference highlighting
        hl.LspReferenceText = { bg = colors.bg_highlight, underline = false }
        hl.LspReferenceRead = { bg = colors.bg_highlight, underline = false }
        hl.LspReferenceWrite = { bg = "#3d4f6d", underline = false }

        -- Full transparency for UI elements
        hl.SignColumn = { bg = "NONE" }
        hl.LineNr = { bg = "NONE" }
        hl.CursorLineNr = { bg = "NONE" }
        hl.FoldColumn = { bg = "NONE" }
        hl.NormalFloat = { bg = "NONE" }
        hl.FloatBorder = { bg = "NONE" }
      end,
    })

    vim.cmd("colorscheme tokyonight")
  end,
}
