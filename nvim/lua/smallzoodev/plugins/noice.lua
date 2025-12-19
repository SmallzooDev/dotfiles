return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = true,
      },
      signature = {
        enabled = true,
      },
    },
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
    },
    messages = {
      enabled = true,
      view = "notify",
    },
    notify = {
      enabled = false,
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
  },
  keys = {
    {
      "<leader>sn",
      function()
        require("noice").cmd("history")
      end,
      desc = "Noice History",
    },
    {
      "<leader>sl",
      function()
        require("noice").cmd("last")
      end,
      desc = "Noice Last Message",
    },
    {
      "<leader>sd",
      function()
        require("noice").cmd("dismiss")
      end,
      desc = "Dismiss All Notifications",
    },
  },
}
