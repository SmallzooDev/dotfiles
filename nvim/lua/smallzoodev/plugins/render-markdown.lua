return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    bullet = { left_pad = 0, right_pad = 1 },
    code = { width = "block", left_pad = 2, right_pad = 2 },
    completions = { lsp = { enabled = true } },
    heading = {
      width = "block",
      left_pad = 1,
      right_pad = 1,
      position = "inline",
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },
    pipe_table = {
      border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
    },
    sign = { enabled = false },
  },
}
