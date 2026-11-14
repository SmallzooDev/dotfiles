return {
  { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "lua" } } },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = { "lua-language-server", "stylua" } } },
  { "stevearc/conform.nvim", opts = { formatters_by_ft = { lua = { "stylua" } } } },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
              hint = {
                enable = true,
                arrayIndex = "Disable",
                setType = true,
              },
            },
          },
        },
      },
    },
  },
}
