return {
  "slugbyte/lackluster.nvim",
  priority = 1000,
  config = function()
    package.loaded["lackluster.plugin.bufferline"] = function() end

    local lackluster = require("lackluster")

    lackluster.setup({
      tweak_syntax = {
        keyword = lackluster.color.blue,
        keyword_return = lackluster.color.green,
        keyword_exception = lackluster.color.blue,
        string = lackluster.color.yellow,
      },
      tweak_highlight = {
        -- LspReferenceText = { overwrite = true, bg = "#2a2a2a", underline = false },
        -- LspReferenceRead = { overwrite = true, bg = "#2a2a2a", underline = false },
        -- LspReferenceWrite = { overwrite = true, bg = "#444444", underline = false },
        -- Render-markdown: headings white, text slightly dim
        -- Heading icons = blue, heading text = white
        RenderMarkdownH1 = { overwrite = true, fg = "#7788aa", bold = true },
        RenderMarkdownH2 = { overwrite = true, fg = "#7788aa", bold = true },
        RenderMarkdownH3 = { overwrite = true, fg = "#7788aa", bold = true },
        RenderMarkdownH4 = { overwrite = true, fg = "#7788aa", bold = true },
        RenderMarkdownH5 = { overwrite = true, fg = "#7788aa", bold = true },
        RenderMarkdownH6 = { overwrite = true, fg = "#7788aa", bold = true },
        ["@markup.heading.1"] = { overwrite = true, fg = "#deeeed", bold = true },
        ["@markup.heading.2"] = { overwrite = true, fg = "#deeeed", bold = true },
        ["@markup.heading.3"] = { overwrite = true, fg = "#deeeed", bold = true },
        ["@markup.heading.4"] = { overwrite = true, fg = "#deeeed", bold = true },
        ["@markup.heading.5"] = { overwrite = true, fg = "#deeeed", bold = true },
        ["@markup.heading.6"] = { overwrite = true, fg = "#deeeed", bold = true },
        RenderMarkdownCode = { overwrite = true, bg = "#191919" },
        RenderMarkdownCodeInline = { overwrite = true, fg = "#ffaa88", bg = "#191919" },
        RenderMarkdownLink = { overwrite = true, fg = "#abab77" },
        RenderMarkdownWikiLink = { overwrite = true, fg = "#abab77" },
        RenderMarkdownBullet = { overwrite = true, fg = "#708090" },
        RenderMarkdownQuote = { overwrite = true, fg = "#555555" },
        RenderMarkdownTodo = { overwrite = true, fg = "#ffaa88" },
        RenderMarkdownProgress = { overwrite = true, fg = "#7788aa" },
        RenderMarkdownImportant = { overwrite = true, fg = "#d70000" },
        RenderMarkdownQuestion = { overwrite = true, fg = "#abab77" },
        RenderMarkdownForward = { overwrite = true, fg = "#789978" },
        RenderMarkdownBack = { overwrite = true, fg = "#789978" },
        RenderMarkdownPartial = { overwrite = true, fg = "#708090" },
        -- Markdown text and emphasis
        ["@markup.raw.markdown_inline"] = { overwrite = true, fg = "#ffaa88", bg = "#191919" },
        ["@markup.strong"] = { overwrite = true, fg = "#deeeed", bold = true },
        ["@markup.emphasis"] = { overwrite = true, fg = "#708090", italic = true },
        ["@markup.raw.block"] = { overwrite = true, bg = "#191919" },
        ["@text.literal"] = { overwrite = true, fg = "#ffaa88", bg = "#191919" },
      },
    })

    vim.cmd("colorscheme lackluster-hack")
  end,
}
