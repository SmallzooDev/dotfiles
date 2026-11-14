return {
  { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "rust" } } },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = { "rust-analyzer" } } },
  { "stevearc/conform.nvim", opts = { formatters_by_ft = { rust = { "rustfmt" } } } },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                features = "all",
              },
              check = {
                command = "clippy",
              },
              inlayHints = {
                closingBraceHints = { minLines = 10 },
              },
            },
          },
        },
      },
    },
  },
}
