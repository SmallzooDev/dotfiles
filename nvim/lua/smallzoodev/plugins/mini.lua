return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.ai").setup({
      n_lines = 500,
      mappings = {
        around_next = "",
        inside_next = "",
        around_last = "",
        inside_last = "",
      },
    })

    require("mini.surround").setup({
      mappings = {
        find = "",
        find_left = "",
      },
    })

    require("mini.pairs").setup({
      modes = { insert = true, command = true, terminal = false },
    })

    require("mini.indentscope").setup({
      symbol = "│",
      options = { try_as_border = true },
      mappings = {
        object_scope = "",
        object_scope_with_border = "",
        goto_top = "",
        goto_bottom = "",
      },
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
