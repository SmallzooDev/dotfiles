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

    local function apply_snacks_hl()
      for _, group in ipairs(snacks_bg_groups) do
        vim.api.nvim_set_hl(0, group, { link = "Normal" })
      end
      vim.api.nvim_set_hl(0, "SnacksPickerBorder", { link = "FloatBorder" })
      vim.api.nvim_set_hl(0, "SnacksPickerTitle", { link = "FloatTitle" })
    end

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

      apply_snacks_hl()
    end

    require("cyberdream").setup({
      variant = "default",
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      terminal_colors = false,
      cache = true,
      borderless_pickers = false,
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
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "snacks_picker_list", "snacks_picker_input", "snacks_picker_preview" },
      callback = apply_snacks_hl,
    })
  end,
}
