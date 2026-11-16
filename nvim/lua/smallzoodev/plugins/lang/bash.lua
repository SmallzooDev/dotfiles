return {
  { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = { "bash-language-server" } } },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "bash", "sh", "zsh" },
          settings = { bashIde = { logLevel = "error" } },
        },
      },
    },
  },
}
