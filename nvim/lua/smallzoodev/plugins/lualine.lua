return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", "stevearc/aerial.nvim" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    lualine.setup({
      options = {
        theme = "catppuccin-mocha",
      },
      sections = {
        lualine_c = {
          { "filename", path = 1, symbols = { modified = " ●", readonly = " " } },
          { "aerial", sep = " > ", depth = 5, colored = true },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = function()
              return { fg = require("catppuccin.palettes").get_palette("mocha").yellow }
            end,
          },
          { "fileformat", symbols = { unix = "" } },
          { "filetype" },
        },
      },
    })
  end,
}
