return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree float toggle reveal<cr>", desc = "Toggle file explorer" },
    { "<leader>E", "<cmd>Neotree float reveal<cr>", desc = "Reveal current file in explorer" },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      hijack_netrw_behavior = "disabled",
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    window = {
      position = "float",
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
      },
      diagnostics = {
        enabled = false,
      },
    },
  },
}
