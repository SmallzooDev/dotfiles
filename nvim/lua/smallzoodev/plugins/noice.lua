return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      -- LSP hover, signature help 등을 Noice로 오버라이드
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
    -- cmdline을 상단 중앙에 예쁘게
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
    },
    -- 메시지를 우측 하단에 예쁘게
    messages = {
      enabled = true,
      view = "notify",
    },
    -- 알림을 우측 상단에 예쁘게
    notify = {
      enabled = true,
    },
    -- 검색 결과 카운트
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
      bottom_search = true, -- 검색창을 하단에
      command_palette = true, -- cmdline을 팔레트 스타일로
      long_message_to_split = true, -- 긴 메시지를 split으로
      inc_rename = false,
      lsp_doc_border = true, -- LSP 문서에 테두리
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
