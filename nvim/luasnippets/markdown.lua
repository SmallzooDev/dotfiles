local ls = require("luasnip")
local s, t, i, f = ls.snippet, ls.text_node, ls.insert_node, ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

local vault = vim.fs.normalize("~/private_vault") .. "/"

local function in_vault() return vim.startswith(vim.fs.normalize(vim.api.nvim_buf_get_name(0)), vault) end

local function in_math()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  local parser = vim.treesitter.get_parser(0, "markdown")
  if not parser then
    return false
  end
  parser:parse({ row, 0, row + 1, 0 })
  local inline = parser:children().markdown_inline
  local node = inline and inline:named_node_for_range({ row, col, row, col }, { ignore_injections = true })
  while node do
    if node:type() == "latex_block" then
      return true
    end
    node = node:parent()
  end
  return false
end

local function formula(line) return in_vault() and in_math() and not line:find("\\text{[^}]*$") end

local function text() return in_vault() and not in_math() end

local function word_start(line, trig) return not line:sub(-#trig - 1, -#trig - 1):match("[%a\\]") end

local function formula_word(line, trig) return word_start(line, trig) and formula(line) end

local function nodes(template, defaults)
  local stops = {}
  for k = 1, select(2, template:gsub("<>", "")) do
    stops[k] = i(k, defaults and defaults[k])
  end
  return fmta(template, stops)
end

local function capture(n)
  return f(function(_, snip) return snip.captures[n] end)
end

local function numerator(line)
  if line:sub(-1) ~= "/" then
    return
  end
  local body = line:sub(1, -2)
  if body:sub(-1) == ")" then
    local depth = 0
    for at = #body, 1, -1 do
      local ch = body:sub(at, at)
      if ch == ")" then
        depth = depth + 1
      elseif ch == "(" then
        depth = depth - 1
        if depth == 0 then
          return body:sub(at) .. "/", { body:sub(at + 1, -2) }
        end
      end
    end
    return
  end
  local tail = ""
  while true do
    local script = body:match("[%^_]%b{}$") or body:match("[%^_]%w$")
    if not script then
      break
    end
    tail = script .. tail
    body = body:sub(1, -#script - 1)
  end
  local head = body:match("%d*\\?%a+$") or (tail == "" and body:match("%d+$"))
  if head then
    return head .. tail .. "/", { head .. tail }
  end
end

local char = "([%z\1-\127\194-\244][\128-\191]*)"

local snippets, autosnippets = {}, {}

local function auto(context, body, condition)
  context.wordTrig = false
  context.condition = condition
  context.show_condition = condition == formula_word and formula or condition
  autosnippets[#autosnippets + 1] = s(context, body)
end

auto({ trig = "^mk", trigEngine = "pattern", hidden = true }, { t("$"), i(1), t("$") }, text)
auto({ trig = char .. "mk", trigEngine = "pattern", hidden = true }, {
  f(function(_, snip)
    local before = snip.captures[1]
    return before .. (before:match("^[%s(]$") and "" or " ")
  end),
  t("$"),
  i(1),
  t("$"),
}, function(_, _, captures) return text() and not captures[1]:match("^[%w_\\$]$") end)
auto({ trig = "^dm", trigEngine = "pattern", hidden = true }, nodes("$$\n<>\n$$"), text)
auto(
  { trig = "^ali", trigEngine = "pattern", hidden = true },
  nodes("$$\n\\begin{aligned}\n<>\n\\end{aligned}\n$$"),
  text
)

auto(
  { trig = "/", trigEngine = function() return numerator end, hidden = true },
  { t("\\frac{"), capture(1), t("}{"), i(1), t("}") },
  formula
)
auto({ trig = "%f[%w_\\](%a)(%d)", trigEngine = "pattern", hidden = true }, { capture(1), t("_"), capture(2) }, formula)
auto(
  { trig = "%f[%w_\\](%a)_(%d%d)", trigEngine = "pattern", hidden = true },
  { capture(1), t("_{"), capture(2), t("}") },
  formula
)
auto(
  { trig = "%f[%w_\\](%a)bar", trigEngine = "pattern", hidden = true },
  { t("\\overline{"), capture(1), t("}") },
  formula
)
auto({ trig = "%f[%w_\\](%a)hat", trigEngine = "pattern", hidden = true }, { t("\\hat{"), capture(1), t("}") }, formula)

auto({ trig = "<->", priority = 2000 }, t("\\leftrightarrow "), formula)

for trig, template in pairs({
  ["//"] = "\\frac{<>}{<>}",
  ["__"] = "_{<>}",
  td = "^{<>}",
  rd = "^{(<>)}",
  sr = "^2",
  cb = "^3",
  invs = "^{-1}",
  compl = "^{c}",
  ["=="] = "&= <> \\\\",
  ["=>"] = "\\implies ",
  ["=<"] = "\\impliedby ",
  ["<="] = "\\le ",
  [">="] = "\\ge ",
  ["!="] = "\\neq ",
  ["~~"] = "\\sim ",
  [">>"] = "\\gg ",
  ["<<"] = "\\ll ",
  ["->"] = "\\to ",
  ["!>"] = "\\mapsto ",
  ["**"] = "\\cdot ",
  ["..."] = "\\ldots",
  ["||"] = "\\mid ",
  ["::"] = "\\colon ",
  ["\\\\\\"] = "\\setminus ",
}) do
  auto({ trig = trig }, nodes(template), formula)
end

for trig, template in pairs({
  iff = "\\iff ",
  eqq = "\\equiv ",
  px = "\\approx ",
  pt = "\\propto ",
  xx = "\\times ",
  cdd = "\\cdots",
  ooo = "\\infty",
  inn = "\\in ",
  notin = "\\notin ",
  cc = "\\subset ",
  Nn = "\\cap ",
  UU = "\\cup ",
  nnn = "\\bigcap_{<>} ",
  uuu = "\\bigcup_{<>} ",
  OO = "\\emptyset",
  EE = "\\exists ",
  AA = "\\forall ",
  NN = "\\mathbb{N}",
  ZZ = "\\mathbb{Z}",
  QQ = "\\mathbb{Q}",
  RR = "\\mathbb{R}",
  bar = "\\overline{<>}",
  hat = "\\hat{<>}",
  vv = "\\vec{<>}",
  mcal = "\\mathcal{<>}",
  mbb = "\\mathbb{<>}",
  mbf = "\\mathbf{<>}",
  rmm = "\\mathrm{<>}",
  tt = "\\text{<>}",
  bb = "\\boxed{<>}",
  ee = "e^{<>}",
  sq = "\\sqrt{<>}",
  case = "\\begin{cases}\n\t<>\n\\end{cases}",
  pmat = "\\begin{pmatrix} <> \\end{pmatrix}",
  bmat = "\\begin{bmatrix} <> \\end{bmatrix}",
  lrp = "\\left( <> \\right)",
  lrs = "\\left[ <> \\right]",
  lrb = "\\left\\lbrace <> \\right\\rbrace",
  lra = "\\left\\langle <> \\right\\rangle",
  ceil = "\\left\\lceil <> \\right\\rceil",
  floor = "\\left\\lfloor <> \\right\\rfloor",
  abs = "\\lvert <> \\rvert",
  norm = "\\lVert <> \\rVert",
  set = "\\lbrace <> \\rbrace",
}) do
  auto({ trig = trig }, nodes(template), formula_word)
end

for name in
  (
    "sin cos tan cot sec csc ln log exp perp arcsin arccos arctan pi zeta int "
    .. "alpha beta gamma delta epsilon theta lambda mu sigma phi omega Delta Sigma Omega"
  ):gmatch("%S+")
do
  auto({ trig = name }, t("\\" .. name), formula_word)
end

for _, entry in ipairs({
  { "sum", "합", "\\sum_{<>}^{<>} ", { "k=1", "n" } },
  { "prod", "곱", "\\prod_{<>}^{<>} ", { "k=1", "n" } },
  { "lim", "극한", "\\lim_{<> \\to <>} ", { "n", "\\infty" } },
  { "limsup", "상극한", "\\limsup_{<> \\to <>} ", { "n", "\\infty" } },
  { "dint", "정적분", "\\int_{<>}^{<>} <> \\, d<>", { "a", "b", "", "x" } },
  { "iint", "이중 적분", "\\iint" },
  { "iiint", "삼중 적분", "\\iiint" },
  { "oint", "닫힌 경로 적분", "\\oint" },
  { "binom", "조합", "\\binom{<>}{<>}", { "n", "k" } },
  { "part", "편미분", "\\frac{\\partial <>}{\\partial <>}", { "", "x" } },
  { "ddx", "미분", "\\frac{d <>}{d<>}", { "", "x" } },
  { "taylor", "테일러 급수", "\\sum_{k=0}^{\\infty} <> (x-a)^k", { "c_k" } },
  { "cvec", "열벡터", "\\begin{pmatrix} <>_<> \\\\ \\vdots \\\\ <>_<> \\end{pmatrix}", { "x", "1", "x", "n" } },
  {
    "bigfun",
    "함수의 정의역과 대응",
    "\\begin{aligned}\n<>\\colon <> &\\longrightarrow <> \\\\\n<> &\\longmapsto <>\n\\end{aligned}",
    { "f", "A", "B", "x", "f(x)" },
  },
  { "sts", "글자 아래 첨자", "_{\\text{<>}}" },
  { "parallel", "평행", "\\parallel " },
  { "nabla", "나블라", "\\nabla " },
  { "ell", "필기체 l", "\\ell" },
  { "qq", "넓은 간격", "\\qquad " },
  { "q", "간격", "\\quad " },
  { "tor", "또는", "\\text{ 또는 }" },
  { "tand", "이고", "\\text{ 이고 }" },
  { "tso", "이므로", "\\text{ 이므로 }" },
  { "tif", "이면", "\\text{ 이면 }" },
}) do
  snippets[#snippets + 1] =
    s({ trig = entry[1], desc = entry[2], condition = formula, show_condition = formula }, nodes(entry[3], entry[4]))
end

return snippets, autosnippets
