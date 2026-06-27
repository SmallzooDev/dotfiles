return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local border_color = "#5ef1ff"
    local comment_color = "#9aa3b5"
    local line_nr_color = "#7b8496"
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
      "MiniInputBorder",
      "MiniNotifyBorder",
      "MiniPickBorder",
      "NeoTreeFloatBorder",
      "DapUIFloatBorder",
      "LspInfoBorder",
    }
    local title_groups = {
      "FzfLuaTitle",
      "FzfLuaPreviewTitle",
      "TelescopeTitle",
    }

    local function set_custom_hl()
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = border_color })
      vim.api.nvim_set_hl(0, "FloatTitle", { fg = border_color })
      vim.api.nvim_set_hl(0, "Comment", { fg = comment_color, italic = true })
      vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = line_nr_color })
      vim.api.nvim_set_hl(0, "LineNrAbove", { fg = line_nr_color })
      vim.api.nvim_set_hl(0, "LineNrBelow", { fg = line_nr_color })

      for _, group in ipairs(border_groups) do
        vim.api.nvim_set_hl(0, group, { link = "FloatBorder" })
      end

      for _, group in ipairs(title_groups) do
        vim.api.nvim_set_hl(0, group, { link = "FloatTitle" })
      end
    end

    require("cyberdream").setup({
      variant = "default",
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      terminal_colors = false,
      cache = true,
      borderless_pickers = true,
      overrides = function(c)
        return {
          CursorLine = { bg = c.bg },
          CursorLineNr = { fg = c.magenta },
        }
      end,
    })

    vim.cmd("colorscheme cyberdream")
    set_custom_hl()

    local group = vim.api.nvim_create_augroup("SmallzoodevHighlights", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = group,
      pattern = "cyberdream",
      callback = set_custom_hl,
    })
  end,
}
