local M = {}

local modes = {
  n = "NORMAL",
  no = "NORMAL",
  v = "VISUAL",
  V = "V-LINE",
  ["\22"] = "V-BLOCK",
  i = "INSERT",
  c = "COMMAND",
  r = "REPLACE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  t = "TERMINAL",
  nt = "TERMINAL",
}

local diagnostic_counts = {}
local group = vim.api.nvim_create_augroup("SmallzoodevStatusline", { clear = true })

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  group = group,
  callback = function(args)
    local counts = {}
    local items = args.data and args.data.diagnostics or vim.diagnostic.get(args.buf)
    for _, diagnostic in ipairs(items) do
      counts[diagnostic.severity] = (counts[diagnostic.severity] or 0) + 1
    end
    diagnostic_counts[args.buf] = counts
    vim.cmd.redrawstatus()
  end,
})

vim.api.nvim_create_autocmd("BufWipeout", {
  group = group,
  callback = function(args)
    diagnostic_counts[args.buf] = nil
  end,
})

local function mode()
  local value = vim.api.nvim_get_mode().mode
  return modes[value] or value:upper()
end

local function filename()
  local value = vim.fn.expand("%:t")
  if value == "" then
    value = "[No Name]"
  end
  if vim.bo.modified then
    value = value .. " [+]"
  end
  if vim.bo.readonly then
    value = value .. " [RO]"
  end
  return value:gsub("%%", "%%%%")
end

local function file_info()
  local encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
  local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "text"
  return table.concat({ encoding, vim.bo.fileformat, filetype }, " ")
end

local function diagnostics()
  local counts = diagnostic_counts[vim.api.nvim_get_current_buf()] or {}
  local parts = {}
  local errors = counts[vim.diagnostic.severity.ERROR] or 0
  local warnings = counts[vim.diagnostic.severity.WARN] or 0
  local hints = counts[vim.diagnostic.severity.HINT] or 0
  local info = counts[vim.diagnostic.severity.INFO] or 0

  if errors > 0 then
    parts[#parts + 1] = "%#DiagnosticError#E:" .. errors .. "%*"
  end
  if warnings > 0 then
    parts[#parts + 1] = "%#DiagnosticWarn#W:" .. warnings .. "%*"
  end
  if hints > 0 then
    parts[#parts + 1] = "%#DiagnosticHint#H:" .. hints .. "%*"
  end
  if info > 0 then
    parts[#parts + 1] = "%#DiagnosticInfo#I:" .. info .. "%*"
  end

  return table.concat(parts, " ")
end

local function recording()
  local register = vim.fn.reg_recording()
  if register == "" then
    return ""
  end
  return "recording @" .. register
end

function M.render()
  local right = {}
  local recording_status = recording()
  local diagnostic_status = diagnostics()

  if recording_status ~= "" then
    right[#right + 1] = recording_status
  end
  if diagnostic_status ~= "" then
    right[#right + 1] = diagnostic_status
  end

  right[#right + 1] = "%l:%c"
  right[#right + 1] = "%p%%"

  return " " .. mode() .. "  " .. filename() .. " %=" .. file_info() .. "%= " .. table.concat(right, "  ") .. " "
end

_G._smallzoodev_statusline = M.render
M.statusline = "%!v:lua._smallzoodev_statusline()"

return M
