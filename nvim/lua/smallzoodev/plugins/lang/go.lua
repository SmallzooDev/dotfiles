return {
  { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "go", "gomod", "gowork", "gosum" } } },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = { ensure_installed = { "gopls", "gofumpt", "goimports", "delve" } },
  },
  { "stevearc/conform.nvim", opts = { formatters_by_ft = { go = { "gofumpt", "goimports" } } } },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = true,
              staticcheck = true,
              semanticTokens = false,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-**/node_modules" },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
      },
    },
  },
}
