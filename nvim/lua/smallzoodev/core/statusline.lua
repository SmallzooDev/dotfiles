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
  local diagnostic_status = package.loaded["vim.diagnostic"] and vim.diagnostic.status() or ""

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

return M
