return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
  config = function()
    require("go").setup({
      -- Disable lsp config since we're using lspconfig directly
      lsp_cfg = false,
      lsp_gofumpt = true,
      lsp_on_attach = false, -- Use our own lspconfig setup
      lsp_keymaps = false, -- Use our own keymaps
      lsp_codelens = true,
      diagnostic = {
        hdlr = false, -- Use nvim default diagnostic handler
      },
      lsp_inlay_hints = {
        enable = true,
      },
      trouble = true,
      luasnip = false, -- We're using blink.cmp
    })

    -- Auto-format and organize imports on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require("go.format").goimport()
      end,
      group = vim.api.nvim_create_augroup("GoFormat", {}),
    })
  end,
  keys = {
    { "<leader>gsj", "<cmd>GoAddTag json<cr>", desc = "Add json struct tags", ft = "go" },
    { "<leader>gsy", "<cmd>GoAddTag yaml<cr>", desc = "Add yaml struct tags", ft = "go" },
    { "<leader>gsr", "<cmd>GoRmTag<cr>", desc = "Remove struct tags", ft = "go" },
    { "<leader>gtf", "<cmd>GoTestFunc<cr>", desc = "Test function", ft = "go" },
    { "<leader>gtp", "<cmd>GoTestPkg<cr>", desc = "Test package", ft = "go" },
    { "<leader>gie", "<cmd>GoIfErr<cr>", desc = "Add if err", ft = "go" },
    { "<leader>gfs", "<cmd>GoFillStruct<cr>", desc = "Fill struct", ft = "go" },
  },
}
