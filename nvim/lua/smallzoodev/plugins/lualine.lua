return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    lualine.setup({
      options = {
        theme = "carbonfox",
      },
      sections = {
        lualine_c = {
          { "filename", path = 1, symbols = { modified = " ●", readonly = " " } },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "fileformat", symbols = { unix = "" } },
          { "filetype" },
        },
      },
    })
  end,
}
