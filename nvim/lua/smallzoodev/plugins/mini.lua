return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.ai").setup({
      n_lines = 500,
    })

    require("mini.surround").setup({
      mappings = {
        add = "sa",
        delete = "sd",
        find = "sf",
        find_left = "sF",
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
