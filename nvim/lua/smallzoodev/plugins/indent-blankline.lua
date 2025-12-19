return {
  "lukas-reineke/indent-blankline.nvim",
  enabled = false, -- using mini.indentscope instead
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { char = "┊" },
  },
}
