return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-mini/mini.icons",
    {
      "s1n7ax/nvim-window-picker",
      name = "window-picker",
      version = "2.*",
      opts = {
        hint = "floating-big-letter",
        filter_rules = {
          include_current_win = false,
          bo = {
            filetype = { "neo-tree", "notify" },
            buftype = { "terminal", "quickfix" },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>e",
      "<cmd>Neotree toggle reveal position=left<cr>",
      desc = "Toggle explorer",
    },
    {
      "<leader>E",
      "<cmd>Neotree reveal dir=%:p:h position=left<cr>",
      desc = "Reveal buffer directory",
    },
  },
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    popup_border_style = "rounded",
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
      },
      git_status = {
        symbols = {
          added = "",
          deleted = "",
          modified = "",
          renamed = "",
          untracked = "",
          ignored = "",
          unstaged = "",
          staged = "",
          conflict = "",
        },
      },
    },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = {
        enabled = true,
      },
      hijack_netrw_behavior = "disabled",
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
      window = {
        mappings = {
          ["<CR>"] = "open",
          ["l"] = "open",
          ["h"] = "close_node",
          ["a"] = "add",
          ["A"] = "add_directory",
          ["d"] = "delete",
          ["r"] = "rename",
          ["m"] = "move",
          ["c"] = "copy",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["y"] = "copy_to_clipboard",
          ["."] = "toggle_hidden",
          ["R"] = "refresh",
          ["?"] = "show_help",
        },
      },
    },
    window = {
      position = "left",
      width = 34,
    },
  },
}
