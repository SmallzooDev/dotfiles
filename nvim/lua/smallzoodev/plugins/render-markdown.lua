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
      icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      width = "full",
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
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
      style = "true",
      width = "full",
      left_pad = 1,
      right_pad = 1,
      language_pad = 1,
      border = "thin",
    },
    bullet = {
      enabled = true,
      icons = { "•", "◦", "▪", "▫" },
    },
    checkbox = {
      enabled = true,
      unchecked = { icon = " " },
      checked = { icon = "󰱒 " },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
        progress = { raw = "[~]", rendered = "󰡖 ", highlight = "RenderMarkdownProgress" },
        important = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownImportant" },
        question = { raw = "[?]", rendered = " ", highlight = "RenderMarkdownQuestion" },
        forward = { raw = "[>]", rendered = " ", highlight = "RenderMarkdownForward" },
        back = { raw = "[<]", rendered = " ", highlight = "RenderMarkdownBack" },
        partial = { raw = "[/]", rendered = "󰡖 ", highlight = "RenderMarkdownPartial" },
      },
    },
    quote = {
      enabled = true,
      -- icon = "▎",
      highlight = "RenderMarkdownQuote",
    },
    link = {
      enabled = true,
      icon = " ",
      highlight = "RenderMarkdownLink",
    },
  },
  config = function(_, opts)
    -- Material Deep Ocean colors
    local colors = {
      cyan = "#89ddff",
      blue = "#82aaff",
      purple = "#c792ea",
      yellow = "#ffcb6b",
      green = "#c3e88d",
      red = "#f07178",
      gray = "#b0bac5",
      white = "#ffffff",
    }

    -- Subtle background colors (darker tinted versions)
    local bg_colors = {
      red = "#3d2527",
      yellow = "#3d3520",
      green = "#2a3224",
      cyan = "#1f2f3d",
      blue = "#1f2a3d",
      purple = "#2f253d",
    }

    -- Heading foreground colors
    vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = colors.red, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = colors.yellow, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = colors.green, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = colors.cyan, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = colors.blue, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = colors.purple, bold = true })

    -- Heading background colors (subtle tinted backgrounds with matching foreground)
    vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = colors.red, bg = bg_colors.red })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = colors.yellow, bg = bg_colors.yellow })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = colors.green, bg = bg_colors.green })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = colors.cyan, bg = bg_colors.cyan })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { fg = colors.blue, bg = bg_colors.blue })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { fg = colors.purple, bg = bg_colors.purple })

    -- Quote highlights (white text)
    vim.api.nvim_set_hl(0, "@markup.quote", { fg = colors.white })

    -- Checkbox highlights
    vim.api.nvim_set_hl(0, "RenderMarkdownTodo", { fg = colors.blue })
    vim.api.nvim_set_hl(0, "RenderMarkdownProgress", { fg = colors.yellow })
    vim.api.nvim_set_hl(0, "RenderMarkdownImportant", { fg = colors.red })
    vim.api.nvim_set_hl(0, "RenderMarkdownQuestion", { fg = colors.purple })
    vim.api.nvim_set_hl(0, "RenderMarkdownForward", { fg = colors.cyan })
    vim.api.nvim_set_hl(0, "RenderMarkdownBack", { fg = colors.gray })
    vim.api.nvim_set_hl(0, "RenderMarkdownPartial", { fg = colors.green })

    require("render-markdown").setup(opts)
  end,
}
