return {
  "EdenEast/nightfox.nvim",
  priority = 1000,
  config = function()
    require("nightfox").setup({
      options = {
        transparent = true,
      },
      groups = {
        all = {
          Comment = { fg = "#a0a0a0" },
          LspInlayHint = { fg = "#b0b0b0" },
          NormalFloat = { bg = "NONE", fg = "#f2f4f8" },
          FloatBorder = { bg = "NONE", fg = "#f2f4f8" },
          FloatTitle = { bg = "NONE", fg = "#f2f4f8" },
          TabLine = { bg = "NONE" },
          TabLineFill = { bg = "NONE" },
          TabLineSel = { bg = "NONE" },
          Pmenu = { bg = "NONE", fg = "#f2f4f8" },
          PmenuSbar = { bg = "NONE", fg = "#f2f4f8" },
          PmenuThumb = { bg = "#f2f4f8", fg = "#f2f4f8" },
          CmpNormal = { bg = "NONE" },
          CmpDoc = { bg = "NONE" },
          CmpDocBorder = { bg = "NONE", fg = "#f2f4f8" },
          BlinkCmpMenu = { bg = "NONE" },
          BlinkCmpMenuBorder = { bg = "NONE", fg = "#f2f4f8" },
          BlinkCmpDoc = { bg = "NONE" },
          BlinkCmpDocBorder = { bg = "NONE", fg = "#f2f4f8" },
          BlinkCmpSignatureHelp = { bg = "NONE" },
          BlinkCmpSignatureHelpBorder = { bg = "NONE", fg = "#f2f4f8" },
          BlinkCmpMenuScrollbar = { bg = "NONE", fg = "#f2f4f8" },
          BlinkCmpDocScrollbar = { bg = "NONE", fg = "#f2f4f8" },
          -- Telescope
          TelescopeBorder = { bg = "NONE", fg = "#f2f4f8" },
          TelescopePromptBorder = { bg = "NONE", fg = "#f2f4f8" },
          TelescopeResultsBorder = { bg = "NONE", fg = "#f2f4f8" },
          TelescopePreviewBorder = { bg = "NONE", fg = "#f2f4f8" },
          TelescopeNormal = { bg = "NONE", fg = "#f2f4f8" },
          TelescopePromptNormal = { bg = "NONE", fg = "#f2f4f8" },
          TelescopeResultsNormal = { bg = "NONE", fg = "#f2f4f8" },
          TelescopePreviewNormal = { bg = "NONE", fg = "#f2f4f8" },
          TelescopeTitle = { bg = "NONE", fg = "#f2f4f8" },
        },
      },
    })
    vim.cmd.colorscheme("carbonfox")

    -- Markdown Headings (treesitter + render-markdown)
    vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = "#ee5396", bold = true })
    vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = "#be95ff", bold = true })
    vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = "#25be6a", bold = true })
    vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = "#78a9ff", bold = true })
    vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = "#ff7eb6", bold = true })
    vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = "#33b1ff", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#ee5396", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#be95ff", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#25be6a", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#78a9ff", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#ff7eb6", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#33b1ff", bold = true })
  end,
}
