return {
  "SmiteshP/nvim-navic",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    lsp = {
      auto_attach = true,
      preference = { "html", "templ" },
    },
    separator = " 󰁔 ",
    highlight = true,
  },
}
