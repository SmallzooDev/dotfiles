return {
  "mikavilpas/yazi.nvim",
  version = "*",
  event = "VeryLazy",
  keys = {
    { "<leader>e", "<cmd>Yazi<cr>", desc = "Open yazi at current file" },
    { "<leader>E", "<cmd>Yazi cwd<cr>", desc = "Open yazi in cwd" },
  },
  opts = {
    open_for_directories = true,
    keymaps = {
      open_file_in_horizontal_split = "<c-s>",
      grep_in_directory = "<c-x>",
    },
    integrations = {
      grep_in_directory = "fzf-lua",
    },
  },
}
