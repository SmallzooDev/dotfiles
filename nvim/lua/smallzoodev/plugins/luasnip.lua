return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  lazy = true,
  opts = { region_check_events = "InsertEnter,CursorMovedI", enable_autosnippets = true },
  config = function(_, opts)
    require("luasnip").setup(opts)
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
    require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/luasnippets" } })
  end,
}
