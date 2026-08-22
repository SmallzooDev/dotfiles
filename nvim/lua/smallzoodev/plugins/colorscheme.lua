local themes = dofile(vim.fn.expand("~/dotfiles/colorscheme/themes.lua"))

local function active_theme()
  local link = vim.fn.resolve(vim.fn.expand("~/dotfiles/colorscheme/current"))
  local name = vim.fn.fnamemodify(link, ":t")
  return name, themes[name] or themes["rose-pine"]
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
        opts = { no_italic = true },
      },
      {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = { styles = { italic = false } },
      },
    },
    config = function()
      require("tokyonight").setup({
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
        on_highlights = function(highlights)
          for _, highlight in pairs(highlights) do
            if type(highlight) == "table" then
              highlight.italic = false
            end
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
    end,
  },
}
