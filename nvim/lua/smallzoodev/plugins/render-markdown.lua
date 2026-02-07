return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    anti_conceal = {
      enabled = true,
    },
    heading = {
      enabled = true,
      sign = false,
      position = "inline",
      icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      width = "full",
      backgrounds = {},
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },
    code = {
      enabled = true,
      sign = false,
      style = "language",
      width = "full",
      left_pad = 1,
      right_pad = 1,
      language_pad = 1,
      border = "none",
      highlight = "",
      highlight_border = "",
    },
    bullet = {
      enabled = true,
      render_modes = false,
      icons = { "󰁕 " },
      ordered_icons = function(ctx)
        local value = vim.trim(ctx.value)
        local index = tonumber(value:sub(1, #value - 1))
        return ("%d."):format(index > 1 and index or ctx.index)
      end,
      left_pad = 0,
      right_pad = 0,
      highlight = "RenderMarkdownBullet",
      scope_highlight = {},
      scope_priority = nil,
    },
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱" },
      checked = { icon = "󰱒" },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔", highlight = "RenderMarkdownTodo" },
        progress = { raw = "[~]", rendered = "󰦖", highlight = "RenderMarkdownProgress" },
        important = { raw = "[!]", rendered = "󰀪", highlight = "RenderMarkdownImportant" },
        question = { raw = "[?]", rendered = "", highlight = "RenderMarkdownQuestion" },
        forward = { raw = "[>]", rendered = "󰁔", highlight = "RenderMarkdownForward" },
        back = { raw = "[<]", rendered = "󰁍", highlight = "RenderMarkdownBack" },
        partial = { raw = "[/]", rendered = "󰄵", highlight = "RenderMarkdownPartial" },
      },
    },
    quote = {
      enabled = true,
      highlight = "RenderMarkdownQuote",
    },
    link = {
      enabled = true,
      render_modes = false,
      footnote = {
        enabled = true,
        icon = "󰯔 ",
        superscript = true,
        prefix = "",
        suffix = "",
      },
      image = "󰥶 ",
      email = "󰀓 ",
      hyperlink = "󰌹 ",
      highlight = "RenderMarkdownLink",
      wiki = {
        icon = "󰌹 ",
        body = function()
          return nil
        end,
        highlight = "RenderMarkdownWikiLink",
        scope_highlight = nil,
      },
      custom = {
        web = { pattern = "^http", icon = "󰖟 " },
        github = { pattern = "github%.com", icon = "󰊤 " },
        google = { pattern = "google%.com", icon = "󰊭 " },
        stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
        youtube = { pattern = "youtube%.com", icon = "󰗃 " },
        slack = { pattern = "slack%.com", icon = " " },
        jira = { pattern = "atlassian%.net/jira", icon = "󰌃 " },
        confluence = { pattern = "atlassian%.net/wiki", icon = "󰈙 " },
      },
    },
  },
}
