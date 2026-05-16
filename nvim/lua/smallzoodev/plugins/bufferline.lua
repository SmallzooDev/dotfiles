return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = { "echasnovski/mini.nvim" },
  opts = {
    options = {
      mode = "buffers",
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diagnostics_dict)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or " ")
          s = s .. n .. sym
        end
        return s
      end,
      separator_style = "thin",
      show_buffer_close_icons = false,
      show_close_icon = false,
      always_show_bufferline = true,
    },
  },
}
