return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "SnacksDashboardOpened",
      callback = function(ev)
        vim.b[ev.buf].miniindentscope_disable = true
      end,
    })
  end,
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

    require("mini.pairs").setup()

    require("mini.comment").setup()

    require("mini.indentscope").setup({
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        delay = 0,
        animation = require("mini.indentscope").gen_animation.none(),
      },
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
  end,
}
