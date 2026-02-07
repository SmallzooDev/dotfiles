return {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        "gopls",
        "rust_analyzer",
        "clangd",
      },
      automatic_enable = false,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "isort",
        "black",
        "gofumpt",
        "goimports",
        "clang-format",
      },
    })
  end,
}
