return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.ai").setup({
      n_lines = 500,
    })

    require("mini.surround").setup({
      mappings = {
        add = "sa",
        delete = "sd",
        find = "",
        find_left = "",
        highlight = "sh",
        replace = "sr",
        update_n_lines = "sn",
      },
    })

    require("mini.pairs").setup({
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    })

    require("mini.comment").setup()

    require("mini.indentscope").setup({
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        delay = 0,
        animation = require("mini.indentscope").gen_animation.none(),
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "Trouble",
        "copilot-chat",
        "help",
        "lazy",
        "mason",
        "notify",
        "snacks_terminal",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })

    require("mini.move").setup({
      mappings = {
        left = "<S-h>",
        right = "<S-l>",
        down = "J",
        up = "K",
        line_left = "<S-h>",
        line_right = "<S-l>",
        line_down = "J",
        line_up = "K",
      },
    })

    require("mini.hipatterns").setup({
      highlighters = {
        hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
      },
    })

    require("mini.icons").setup()
    require("mini.icons").mock_nvim_web_devicons()

  end,
}
