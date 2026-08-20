local themes = dofile(vim.fn.expand("~/dotfiles/colorscheme/themes.lua"))

local function active_theme()
  local link = vim.fn.resolve(vim.fn.expand("~/dotfiles/colorscheme/current"))
  local name = vim.fn.fnamemodify(link, ":t")
  return name, themes[name] or themes["rose-pine"]
end

local function disable_italics()
  for name, highlight in pairs(vim.api.nvim_get_hl(0, {})) do
    if highlight.italic then
      highlight.italic = false
      vim.api.nvim_set_hl(0, name, highlight)
    end
  end
end

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
          flavour = "mocha",
          no_italic = true,
        },
      },
      {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
          variant = "main",
          styles = { italic = false },
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
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = bg_dark
          colors.bg_float = bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = bg_dark
          colors.bg_statusline = bg_dark
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
          hl.GitSignsCurrentLineBlame = { fg = colors.comment }
          hl.LspInlayHint = { fg = colors.fg_gutter }
          hl.DiagnosticHint = { fg = colors.border }
          hl.DiagnosticVirtualTextHint = { fg = colors.border }
        end,
      })

      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        group = vim.api.nvim_create_augroup("SmallzoodevNoItalics", { clear = true }),
        callback = disable_italics,
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
    end,
  },
}
