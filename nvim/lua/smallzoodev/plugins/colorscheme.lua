local themes = dofile(vim.fn.expand("~/dotfiles/colorscheme/themes.lua"))

local function active_theme()
  local link = vim.fn.resolve(vim.fn.expand("~/dotfiles/colorscheme/current"))
  local name = vim.fn.fnamemodify(link, ":t")
  return name, themes[name] or themes["rose-pine"]
end

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
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      {
        "projekt0n/github-nvim-theme",
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
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
          flavour = "mocha",
          transparent_background = true,
        },
      },
      {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
          variant = "main",
          styles = { transparency = true },
        },
      },
    },
    config = function()
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
        transparent = true,
        styles = {
          comments = { italic = true },
          sidebars = "transparent",
          floats = "transparent",
        },
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = colors.none
          colors.bg_float = colors.none
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = colors.none
          colors.bg_statusline = colors.none
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
        on_highlights = function(hl, colors)
          hl.FloatBorder = { fg = colors.cyan }
          hl.FloatTitle = { fg = colors.cyan }
          hl.CursorLine = { bg = colors.bg_highlight }
          hl.CursorLineNr = { fg = colors.cyan, bold = true }
          hl.LspReferenceText = { underline = true, sp = colors.cyan }
          hl.LspReferenceRead = { underline = true, sp = colors.cyan }
          hl.LspReferenceWrite = { underline = true, sp = colors.cyan }
          hl.Search = { bg = colors.bg_search, fg = colors.fg }
          hl.CurSearch = { bg = colors.cyan, fg = colors.bg_dark, bold = true }
          hl.IncSearch = { bg = colors.cyan, fg = colors.bg_dark, bold = true }
          hl.GitSignsAdd = { fg = colors.green }
          hl.GitSignsChange = { fg = colors.yellow }
          hl.GitSignsDelete = { fg = colors.red }
          hl.GitSignsChangedelete = { fg = colors.yellow }
          hl.GitSignsTopdelete = { fg = colors.red }
          hl.GitSignsUntracked = { fg = colors.blue }
          hl.GitSignsCurrentLineBlame = { fg = colors.comment, italic = true }
          hl.LspInlayHint = { fg = colors.fg_gutter, italic = true }
          hl.DiagnosticHint = { fg = colors.border }
          hl.DiagnosticVirtualTextHint = { fg = colors.border }
        end,
      })

      local function style_github()
        local blue_github = "#58a6ff"

        vim.api.nvim_set_hl(0, "FloatBorder", { fg = blue_github })
        vim.api.nvim_set_hl(0, "FloatTitle", { fg = blue_github, bold = true })

        for _, group in ipairs({ "Pmenu", "PmenuSbar" }) do
          local highlight = vim.api.nvim_get_hl(0, { name = group, link = false })
          highlight.bg = nil
          vim.api.nvim_set_hl(0, group, highlight)
        end

        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#182f50" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = blue_github, bold = true })
        for _, group in ipairs({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }) do
          vim.api.nvim_set_hl(0, group, { underline = true, sp = blue_github })
        end

        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        vim.api.nvim_set_hl(0, "StatusLine", { fg = normal.fg, bg = normal.bg })
        vim.api.nvim_set_hl(0, "StatusLineNC", { fg = normal.fg, bg = normal.bg })
        for _, group in ipairs({ "Added", "Changed", "Removed" }) do
          local highlight = vim.api.nvim_get_hl(0, { name = group })
          highlight.bg = nil
          vim.api.nvim_set_hl(0, group, highlight)
        end

        for _, group in ipairs({ "TabLine", "TabLineFill", "BufferLineFill" }) do
          local highlight = vim.api.nvim_get_hl(0, { name = group, link = false })
          highlight.bg = nil
          vim.api.nvim_set_hl(0, group, highlight)
        end
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("SmallzoodevThemeStyle", { clear = true }),
        callback = function(event)
          link_chrome(function(group, value)
            vim.api.nvim_set_hl(0, group, value)
          end)
          if event.match == "github_dark_default" then
            style_github()
          end
        end,
      })

      local applied
      local function apply()
        local name, theme = active_theme()
        if name == applied then
          return
        end
        applied = name
        vim.cmd.colorscheme(theme.nvim)
      end

      apply()

      vim.api.nvim_create_autocmd("FocusGained", {
        group = vim.api.nvim_create_augroup("SmallzoodevThemeFollow", { clear = true }),
        callback = apply,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("SmallzoodevHighlights", { clear = true }),
        pattern = { "snacks_picker_list", "snacks_picker_input", "snacks_picker_preview" },
        callback = function()
          for _, group in ipairs(snacks_bg_groups) do
            vim.api.nvim_set_hl(0, group, { link = "Normal" })
          end
        end,
      })
    end,
  },
}
