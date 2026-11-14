return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    init = function()
      vim.env.PATH = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin") .. ":" .. vim.env.PATH
    end,
    dependencies = { "mason-org/mason-lspconfig.nvim" },
    opts = {
      PATH = "skip",
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup({ automatic_enable = false })
      require("lazy").load({ plugins = { "mason-tool-installer.nvim" } })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "prettier" } },
  },
}
