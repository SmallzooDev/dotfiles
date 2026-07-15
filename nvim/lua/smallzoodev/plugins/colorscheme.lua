return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local transparent = true

    local bg = "#011628"
    local bg_dark = "#011423"
    local bg_highlight = "#143652"
    local bg_search = "#0A64AC"
    local bg_visual = "#275378"
    local fg = "#CBE0F0"
    local fg_dark = "#B4D0E9"
    local fg_gutter = "#627E97"
    local border = "#547998"

    local red = "#E52E2E"
    local green = "#44FFB1"
    local green_bright = "#47FF9C"
    local yellow = "#FFE073"
    local blue = "#0FC5ED"
    local cyan = "#24EAF7"
    local purple = "#a277ff"
    local comment = "#7C91A8"

    local border_groups = {
      "FzfLuaBorder",
      "FzfLuaPreviewBorder",
      "FzfLuaHelpBorder",
      "FzfLuaScrollBorderEmpty",
      "FzfLuaScrollBorderFull",
      "FzfLuaFzfBorder",
      "TelescopeBorder",
      "WhichKeyBorder",
      "NoiceCmdlinePopupBorder",
      "NoicePopupBorder",
      "NoicePopupmenuBorder",
      "NoiceConfirmBorder",
      "NoiceSplitBorder",
      "BlinkCmpMenuBorder",
      "BlinkCmpDocBorder",
      "BlinkCmpSignatureHelpBorder",
      "MiniClueBorder",
      "MiniCmdlinePeekBorder",
      "MiniFilesBorder",
      "MiniInputBorder",
      "MiniNotifyBorder",
      "MiniPickBorder",
      "DapUIFloatBorder",
      "LspInfoBorder",
    }
    local title_groups = {
      "FzfLuaTitle",
      "FzfLuaPreviewTitle",
      "TelescopeTitle",
    }
    local snacks_bg_groups = {
      "SnacksPicker",
      "SnacksPickerNormal",
      "SnacksPickerList",
      "SnacksPickerInput",
      "SnacksPickerPreview",
      "SnacksPickerBox",
    }

    require("tokyonight").setup({
      style = "night",
      transparent = transparent,
      styles = {
        comments = { italic = true },
        sidebars = transparent and "transparent" or "dark",
        floats = transparent and "transparent" or "dark",
      },
      on_colors = function(colors)
        colors.bg = bg
        colors.bg_dark = transparent and colors.none or bg_dark
        colors.bg_float = transparent and colors.none or bg_dark
        colors.bg_highlight = bg_highlight
        colors.bg_popup = bg_dark
        colors.bg_search = bg_search
        colors.bg_sidebar = transparent and colors.none or bg_dark
        colors.bg_statusline = transparent and colors.none or bg_dark
        colors.bg_visual = bg_visual
        colors.border = border
        colors.fg = fg
        colors.fg_dark = fg_dark
        colors.fg_float = fg
        colors.fg_gutter = fg_gutter
        colors.fg_sidebar = fg_dark

        colors.blue = blue
        colors.cyan = cyan
        colors.teal = cyan
        colors.green = green
        colors.green1 = green_bright
        colors.red = red
        colors.red1 = red
        colors.magenta = purple
        colors.purple = purple
        colors.orange = yellow
        colors.yellow = yellow
        colors.comment = comment
      end,
      on_highlights = function(hl, c)
        hl.FloatBorder = { fg = c.cyan }
        hl.FloatTitle = { fg = c.cyan }

        for _, group in ipairs(border_groups) do
          hl[group] = { link = "FloatBorder" }
        end

        for _, group in ipairs(title_groups) do
          hl[group] = { link = "FloatTitle" }
        end

        for _, group in ipairs(snacks_bg_groups) do
          hl[group] = { link = "Normal" }
        end
        hl.SnacksPickerBorder = { link = "FloatBorder" }
        hl.SnacksPickerTitle = { link = "FloatTitle" }

        hl.CursorLine = { bg = c.bg_highlight }
        hl.CursorLineNr = { fg = c.cyan, bold = true }
        hl.LspReferenceText = { underline = true, sp = c.cyan }
        hl.LspReferenceRead = { underline = true, sp = c.cyan }
        hl.LspReferenceWrite = { underline = true, sp = c.cyan }
        hl.Search = { bg = c.bg_search, fg = c.fg }
        hl.CurSearch = { bg = c.cyan, fg = c.bg_dark, bold = true }
        hl.IncSearch = { bg = c.cyan, fg = c.bg_dark, bold = true }
        hl.GitSignsAdd = { fg = c.green }
        hl.GitSignsChange = { fg = c.yellow }
        hl.GitSignsDelete = { fg = c.red }
        hl.GitSignsChangedelete = { fg = c.yellow }
        hl.GitSignsTopdelete = { fg = c.red }
        hl.GitSignsUntracked = { fg = c.blue }
        hl.GitSignsCurrentLineBlame = { fg = c.comment, italic = true }
        hl.LspInlayHint = { fg = c.fg_gutter, italic = true }
        hl.DiagnosticHint = { fg = c.border }
        hl.DiagnosticVirtualTextHint = { fg = c.border }
      end,
    })

    vim.cmd("colorscheme tokyonight")

    local group = vim.api.nvim_create_augroup("SmallzoodevHighlights", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "snacks_picker_list", "snacks_picker_input", "snacks_picker_preview" },
      callback = function()
        for _, snacks_group in ipairs(snacks_bg_groups) do
          vim.api.nvim_set_hl(0, snacks_group, { link = "Normal" })
        end
      end,
    })
  end,
}
