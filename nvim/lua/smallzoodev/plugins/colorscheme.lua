return {
  "marko-cerovac/material.nvim",
  priority = 1000,
  config = function()
    require("material").setup({
      contrast = {
        terminal = false,
        sidebars = false,
        floating_windows = false,
        cursor_line = false,
        lsp_virtual_text = false,
        non_current_windows = false,
        filetypes = {},
      },
      styles = {
        comments = { italic = true },
        strings = {},
        keywords = {},
        functions = {},
        variables = {},
        operators = {},
        types = {},
      },
      plugins = {
        "gitsigns",
        "nvim-cmp",
        "nvim-web-devicons",
        "telescope",
        "which-key",
      },
      disable = {
        colored_cursor = false,
        borders = false,
        background = false,
        term_colors = false,
        eob_lines = false,
      },
      high_visibility = {
        lighter = false,
        darker = false,
      },
      lualine_style = "default",
      async_loading = true,
      custom_colors = nil,
      custom_highlights = {
        Cursor = { bg = "#89ddff", fg = "#0f111a" },
        CursorLine = { bg = "#1a1e2e" },
      },
    })

    vim.g.material_style = "deep ocean"
    vim.cmd.colorscheme("material")
  end,
}
