-- Overcast theme - EXACT Raycast colors
local bg = "#D8E5EB"
local bg_dark = "#CDD9E2"
local bg_highlight = "#C5D8ED"
local bg_search = "#B0CADE"
local bg_visual = "#C5D8ED"
local fg = "#0D296D"
local fg_dark = "#0A1F54"
local fg_gutter = "#4A6798"
local border = "#B8CFDD"

-- Color palette
local blue = "#6B89C8"
local cyan = "#5FC9D8"
local green = "#0D6B2E"
local magenta = "#9B7FCE"
local orange = "#E89B63"
local red = "#E07A7A"
local yellow = "#E8B563"

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Clear existing
vim.api.nvim_command("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.api.nvim_command("syntax reset")
end
vim.g.colors_name = "overcast"

-- Editor
hi("Normal", { fg = fg, bg = bg })
hi("NormalFloat", { fg = fg, bg = bg_dark })
hi("FloatBorder", { fg = border, bg = bg_dark })
hi("Cursor", { fg = bg, bg = fg })
hi("CursorLine", { bg = bg_highlight })
hi("CursorColumn", { bg = bg_highlight })
hi("LineNr", { fg = fg_gutter })
hi("CursorLineNr", { fg = fg, bold = true })
hi("SignColumn", { bg = bg })
hi("VertSplit", { fg = border })
hi("WinSeparator", { fg = border })
hi("StatusLine", { fg = fg, bg = bg_dark })
hi("StatusLineNC", { fg = fg_gutter, bg = bg_dark })
hi("Pmenu", { fg = fg, bg = bg_dark })
hi("PmenuSel", { fg = bg, bg = blue })
hi("PmenuSbar", { bg = bg_highlight })
hi("PmenuThumb", { bg = fg_gutter })
hi("Visual", { bg = bg_visual })
hi("Search", { bg = bg_search })
hi("IncSearch", { fg = bg, bg = orange })

-- Tabs
hi("TabLineFill", { bg = bg })
hi("TabLine", { fg = fg_gutter, bg = bg })
hi("TabLineSel", { fg = fg, bg = bg, bold = true })

-- Syntax
hi("Comment", { fg = fg_gutter, italic = true })
hi("String", { fg = green })
hi("Number", { fg = orange })
hi("Boolean", { fg = orange })
hi("Function", { fg = blue })
hi("Identifier", { fg = fg })
hi("Statement", { fg = magenta })
hi("Keyword", { fg = magenta })
hi("Operator", { fg = cyan })
hi("Type", { fg = cyan })
hi("Constant", { fg = orange })
hi("Special", { fg = yellow })
hi("Error", { fg = red })
hi("Todo", { fg = yellow, bold = true })

-- TreeSitter
hi("@comment", { link = "Comment" })
hi("@string", { link = "String" })
hi("@number", { link = "Number" })
hi("@boolean", { link = "Boolean" })
hi("@function", { link = "Function" })
hi("@keyword", { link = "Keyword" })
hi("@operator", { link = "Operator" })
hi("@type", { link = "Type" })
hi("@constant", { link = "Constant" })
hi("@variable", { fg = fg })

-- Markdown
hi("@markup.heading", { fg = fg, bold = true })
hi("@markup.heading.1", { fg = fg, bold = true })
hi("@markup.heading.2", { fg = fg, bold = true })
hi("@markup.heading.3", { fg = fg, bold = true })
hi("@markup.heading.4", { fg = fg, bold = true })
hi("@markup.heading.5", { fg = fg, bold = true })
hi("@markup.heading.6", { fg = fg, bold = true })
hi("@markup.strong", { fg = fg, bold = true })
hi("@markup.italic", { fg = fg, italic = true })
hi("@markup.strikethrough", { fg = fg_gutter, strikethrough = true })
hi("@markup.underline", { fg = fg, underline = true })
hi("@markup.list", { fg = fg })
hi("@markup.list.checked", { fg = green })
hi("@markup.list.unchecked", { fg = fg_gutter })
hi("@markup.quote", { fg = fg_gutter, italic = true })
hi("@markup.raw", { fg = green })
hi("@markup.raw.block", { fg = green })

-- Markdown links (파란색/시안색만)
hi("@markup.link", { fg = blue, underline = true })
hi("@markup.link.url", { fg = cyan, underline = true })
hi("@markup.link.label", { fg = blue })
hi("@markup.link.label.markdown_inline", { fg = blue })
hi("@markup.link.url.markdown_inline", { fg = cyan, underline = true })
hi("@text.uri", { fg = cyan, underline = true })
hi("@text.reference", { fg = blue, underline = true })
hi("markdownUrl", { fg = cyan, underline = true })
hi("markdownLink", { fg = blue, underline = true })
hi("markdownLinkText", { fg = blue, underline = true })
hi("markdownH1", { fg = fg, bold = true })
hi("markdownH2", { fg = fg, bold = true })
hi("markdownH3", { fg = fg, bold = true })
hi("markdownH4", { fg = fg, bold = true })
hi("markdownH5", { fg = fg, bold = true })
hi("markdownH6", { fg = fg, bold = true })

-- Spell checking
hi("@spell", { fg = fg })
hi("@nospell", { fg = fg })

-- Headlines plugin
hi("Headline1", { bg = "#C5D8ED", fg = fg, bold = true })
hi("Headline2", { bg = "#CDD9E2", fg = fg, bold = true })
hi("Headline3", { bg = "#D2E0E8", fg = fg_gutter, bold = true })
hi("Headline4", { bg = bg, fg = fg_gutter })
hi("Headline5", { bg = "#DDE8EE", fg = fg_gutter })
hi("Headline6", { bg = "#E5EFF3", fg = fg_gutter })
hi("CodeBlock", { bg = "#D0DCE5" })
hi("Dash", { fg = fg_gutter })
hi("Quote", { fg = fg, italic = true })

-- Bufferline
hi("BufferLineFill", { bg = bg })
hi("BufferLineBackground", { bg = bg, fg = fg_gutter })
hi("BufferLineTab", { bg = bg, fg = fg_gutter })
hi("BufferLineTabSelected", { bg = bg, fg = fg, bold = true })
hi("BufferLineTabSeparator", { bg = bg, fg = bg })
hi("BufferLineTabSeparatorSelected", { bg = bg, fg = bg })
hi("BufferLineTabClose", { bg = bg, fg = fg_gutter })
hi("BufferLineCloseButton", { bg = bg, fg = fg_gutter })
hi("BufferLineCloseButtonSelected", { bg = bg, fg = fg })
hi("BufferLineModified", { bg = bg, fg = fg_gutter })
hi("BufferLineModifiedSelected", { bg = bg, fg = fg })

-- Git
hi("DiffAdd", { fg = green, bg = bg })
hi("DiffChange", { fg = yellow, bg = bg })
hi("DiffDelete", { fg = red, bg = bg })
hi("GitSignsAdd", { fg = green })
hi("GitSignsChange", { fg = yellow })
hi("GitSignsDelete", { fg = red })

-- Diagnostic
hi("DiagnosticError", { fg = red })
hi("DiagnosticWarn", { fg = yellow })
hi("DiagnosticInfo", { fg = cyan })
hi("DiagnosticHint", { fg = blue })

-- Conceal (숨겨진 텍스트 - 링크 관련)
hi("Conceal", { fg = blue })
hi("markdownLinkDelimiter", { fg = blue })
hi("markdownLinkTextDelimiter", { fg = blue })
hi("markdownUrlDelimiter", { fg = cyan })

-- Special 문자들
hi("SpecialChar", { fg = cyan })
hi("SpecialComment", { fg = fg_gutter })
hi("Delimiter", { fg = fg })

-- 추가 마크다운
hi("markdownCode", { fg = green })
hi("markdownCodeDelimiter", { fg = green })
hi("markdownHeadingDelimiter", { fg = fg })
