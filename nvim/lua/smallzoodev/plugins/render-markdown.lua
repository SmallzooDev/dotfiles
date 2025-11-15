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
      render_modes = false,
      icons = { " ", " ", "󰶻 " },
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
  config = function(_, opts)
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

    local bg_colors = {
      red = "#3d2527",
      yellow = "#3d3520",
      green = "#2a3224",
      cyan = "#1f2f3d",
      blue = "#1f2a3d",
      purple = "#2f253d",
    }

    vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = colors.red, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = colors.yellow, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = colors.green, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = colors.cyan, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = colors.blue, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = colors.purple, bold = true })

    vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = colors.red, bg = bg_colors.red })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = colors.yellow, bg = bg_colors.yellow })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = colors.green, bg = bg_colors.green })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = colors.cyan, bg = bg_colors.cyan })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { fg = colors.blue, bg = bg_colors.blue })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { fg = colors.purple, bg = bg_colors.purple })

    vim.api.nvim_set_hl(0, "@markup.quote", { fg = colors.white })

    -- Bullet highlight (green)
    vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = colors.green })

    -- Link highlights (icon: green, text: cyan)
    vim.api.nvim_set_hl(0, "RenderMarkdownLink", { fg = colors.green })
    vim.api.nvim_set_hl(0, "@markup.link", { fg = colors.cyan })
    vim.api.nvim_set_hl(0, "@markup.link.label", { fg = colors.cyan })
    vim.api.nvim_set_hl(0, "@markup.link.url", { fg = colors.cyan })

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
