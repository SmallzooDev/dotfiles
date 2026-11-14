return {
  { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "c", "cpp", "cmake" } } },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = { "clangd", "clang-format" } } },
  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { c = { "clang-format" }, cpp = { "clang-format" } } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
          },
        },
      },
    },
  },
}
