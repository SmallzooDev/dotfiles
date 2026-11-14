return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
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
    },
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = true, opts = { no_italic = true } },
  { "rose-pine/neovim", name = "rose-pine", lazy = true, opts = { styles = { italic = false } } },
}
