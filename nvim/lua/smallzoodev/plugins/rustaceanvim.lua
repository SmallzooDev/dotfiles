return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  ft = { "rust" },
  opts = {
    server = {
      on_attach = function(client, bufnr)
        -- Use our standard LSP keymaps from lspconfig
      end,
      default_settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          checkOnSave = {
            command = "clippy",
          },
          procMacro = {
            enable = true,
          },
        },
      },
    },
  },
  config = function(_, opts)
    vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
  end,
}
