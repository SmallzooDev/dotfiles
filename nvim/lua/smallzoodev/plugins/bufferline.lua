return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    highlights = {
      fill = {
        bg = { attribute = "bg", highlight = "Normal" },
      },
    },
    options = {
      mode = "buffers",
      numbers = "none",
      diagnostics = false,
      indicator = { style = "none" },
      separator_style = "thin",
      show_buffer_icons = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = false,
      always_show_bufferline = false,
      modified_icon = "[+]",
      left_trunc_marker = "<",
      right_trunc_marker = ">",
    },
  },
}
