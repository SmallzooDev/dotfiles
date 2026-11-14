return {
  "zk-org/zk-nvim",
  name = "zk",
  ft = "markdown",
  keys = {
    { "<leader>OT", "<cmd>ZkNew { dir = 'daily' }<CR>", desc = "Today's note" },
    { "<leader>Ot", "<cmd>ZkTags<CR>", desc = "Search tags" },
  },
  opts = {
    picker = "fzf_lua",
    lsp = {
      config = {
        on_attach = function(_, bufnr)
          if require("zk.util").notebook_root(vim.api.nvim_buf_get_name(bufnr)) then
            vim.keymap.set("n", "<CR>", "gd", { buffer = bufnr, remap = true, desc = "Follow link" })
          end
        end,
      },
    },
  },
}
