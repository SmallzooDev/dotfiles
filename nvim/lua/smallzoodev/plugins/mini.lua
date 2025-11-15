return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    -- Better Around/Inside textobjects
    require("mini.ai").setup({
      n_lines = 500,
    })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require("mini.surround").setup({
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    })

    -- Auto pairs
    require("mini.pairs").setup()

    -- Fast and familiar per-line commenting
    require("mini.comment").setup()

    -- Visualize and work with indent scope
    require("mini.indentscope").setup({
      symbol = "│",
      options = { try_as_border = true },
    })

    -- Better text-objects
    require("mini.move").setup({
      -- Move visual selection in Visual mode
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
