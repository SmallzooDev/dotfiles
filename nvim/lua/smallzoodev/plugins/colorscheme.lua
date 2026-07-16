-- Active theme is chosen by the `theme` shell script via colorscheme/current.
local function active_theme()
  local link = vim.fn.resolve(vim.fn.expand("~/dotfiles/colorscheme/current"))
  return vim.fn.fnamemodify(link, ":t") == "github-dark" and "github-dark" or "coolnight"
end

-- Highlight-group families shared by both themes.
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

local function link_chrome(set)
  for _, group in ipairs(border_groups) do
    set(group, { link = "FloatBorder" })
  end
  for _, group in ipairs(title_groups) do
    set(group, { link = "FloatTitle" })
  end
  for _, group in ipairs(snacks_bg_groups) do
    set(group, { link = "Normal" })
  end
  set("SnacksPickerBorder", { link = "FloatBorder" })
  set("SnacksPickerTitle", { link = "FloatTitle" })
end

return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
          styles = { comments = "italic" },
        },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "projekt0n/github-nvim-theme" },
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
          link_chrome(function(group, value)
            hl[group] = value
          end)

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

      -- github-dark: this config's UI expects float borders/titles and a clean
      -- fg-only statusline; github-theme ships coloured bars, so neutralise them.
      local gh_blue = "#58a6ff"
      local gh_cursorline = "#182f50"

      local function style_github()
        link_chrome(function(group, value)
          vim.api.nvim_set_hl(0, group, value)
        end)

        -- Bright, visible float borders + transparent popup backgrounds
        -- (github's FloatBorder is near-invisible #161b22 and Pmenu is solid near-black).
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = gh_blue })
        vim.api.nvim_set_hl(0, "FloatTitle", { fg = gh_blue, bold = true })
        for _, group in ipairs({ "Pmenu", "PmenuSbar" }) do
          local h = vim.api.nvim_get_hl(0, { name = group, link = false })
          h.bg = nil
          vim.api.nvim_set_hl(0, group, h)
        end

        -- CursorLine: calm blue instead of github's bright gray (#484f58); a touch brighter than base navy.
        vim.api.nvim_set_hl(0, "CursorLine", { bg = gh_cursorline })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = gh_blue, bold = true })
        -- LSP document highlights: underline like coolnight, not a solid blue block.
        for _, group in ipairs({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }) do
          vim.api.nvim_set_hl(0, group, { underline = true, sp = gh_blue })
        end

        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        vim.api.nvim_set_hl(0, "StatusLine", { fg = normal.fg, bg = normal.bg })
        vim.api.nvim_set_hl(0, "StatusLineNC", { fg = normal.fg, bg = normal.bg })
        for _, group in ipairs({ "Added", "Changed", "Removed" }) do
          local h = vim.api.nvim_get_hl(0, { name = group })
          h.bg = nil
          vim.api.nvim_set_hl(0, group, h)
        end

        -- Keep the bufferline/tabline bar transparent like coolnight; github paints it solid.
        for _, group in ipairs({ "TabLine", "TabLineFill", "BufferLineFill" }) do
          local h = vim.api.nvim_get_hl(0, { name = group, link = false })
          h.bg = nil
          vim.api.nvim_set_hl(0, group, h)
        end
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("SmallzoodevGithubFix", { clear = true }),
        pattern = "github_dark_default",
        callback = style_github,
      })

      -- Apply the active theme; follow the shell switcher when the window regains focus.
      local applied
      local function apply()
        local t = active_theme()
        if t == applied then
          return
        end
        applied = t
        vim.cmd.colorscheme(t == "github-dark" and "github_dark_default" or "tokyonight")
      end
      apply()

      vim.api.nvim_create_autocmd("FocusGained", {
        group = vim.api.nvim_create_augroup("SmallzoodevThemeFollow", { clear = true }),
        callback = apply,
      })

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
  },
}
