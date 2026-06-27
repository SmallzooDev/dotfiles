local M = {}

local mode_map = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["i"] = "INSERT",
  ["c"] = "COMMAND",
  ["r"] = "REPLACE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
  ["nt"] = "TERMINAL",
}

local mode_hl_map = {
  ["NORMAL"] = "Directory",
  ["VISUAL"] = "Number",
  ["V-LINE"] = "Number",
  ["V-BLOCK"] = "Number",
  ["INSERT"] = "String",
  ["COMMAND"] = "Keyword",
  ["TERMINAL"] = "Keyword",
}

function _G._statusline_component(name, hl)
  return M[name](hl)
end

local function format_component(val, hl, l_sep, r_sep)
  l_sep = l_sep or " "
  r_sep = r_sep or " "
  hl = hl or "Comment"
  return l_sep .. "%#" .. hl .. "#" .. val .. "%*" .. r_sep
end

local function component(val, hl)
  if val == nil or val == "" then
    return ""
  end
  if hl == nil then
    return "%{%v:lua._statusline_component('" .. val .. "')%}"
  end
  return "%{%v:lua._statusline_component('" .. val .. "', '" .. hl .. "')%}"
end

local function get_diagnostic_count(severity)
  return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[severity] })
end

local function get_mode_info()
  local mode = vim.api.nvim_get_mode().mode
  local val = mode_map[mode]
  return val, mode_hl_map[val]
end

M.mode = function()
  local val, hl = get_mode_info()
  if not val then
    return ""
  end
  return format_component(" " .. string.lower(val), hl)
end

M.git_branch = function(hl)
  local branch = vim.g.gitsigns_head
  if not branch then
    return ""
  end
  return format_component(" " .. branch, hl)
end

M.git_diff = function(hl)
  local summary = vim.b.gitsigns_status
  if not summary or summary == "" then
    return ""
  end
  summary = summary:gsub("+", " ")
  summary = summary:gsub("-", " ")
  summary = summary:gsub("~", " ")
  return format_component(summary, hl)
end

M.diagnostics = function()
  local errors = get_diagnostic_count("ERROR")
  local warnings = get_diagnostic_count("WARN")
  local hints = get_diagnostic_count("HINT")
  local info = get_diagnostic_count("INFO")

  if errors + warnings + hints + info == 0 then
    return ""
  end

  local parts = {
    errors > 0 and format_component(" " .. errors, "DiagnosticError", "") or "",
    warnings > 0 and format_component(" " .. warnings, "DiagnosticWarn", "") or "",
    hints > 0 and format_component(" " .. hints, "DiagnosticHint", "") or "",
    info > 0 and format_component("󰝶 " .. info, "DiagnosticInfo", "") or "",
  }

  return " " .. table.concat(parts, "") .. " "
end

M.navic = function(hl)
  if package.loaded["nvim-navic"] and require("nvim-navic").is_available() then
    return format_component(require("nvim-navic").get_location(), hl)
  end
  return ""
end

M.status_messages = function(hl)
  local reg = vim.fn.reg_recording()
  if reg ~= "" then
    return format_component("recording @" .. reg, hl)
  end
  return ""
end

M.lazy_updates = function(hl)
  local ok, lazy_status = pcall(require, "lazy.status")
  if not ok then
    return ""
  end
  local updates = lazy_status.updates()
  if type(updates) == "string" then
    return format_component(updates, hl)
  end
  return ""
end

M.search_count = function(hl)
  if vim.v.hlsearch == 0 then
    return ""
  end
  local ok, s_count = pcall(vim.fn.searchcount, { recompute = true })
  if not ok or s_count.current == nil or s_count.total == 0 then
    return ""
  end
  if s_count.incomplete == 1 then
    return format_component("?/?", hl)
  end
  return format_component(s_count.current .. "/" .. s_count.total, hl)
end

M.file_name = function(hl)
  local ft_overrides = {
    ["grug-far"] = { name = "grug-far", icon = "", icon_hl = "DiagnosticWarn" },
    ["lazy"] = { name = "lazy.nvim", icon = "󰒲", icon_hl = "Directory" },
    ["mason"] = { name = "mason", icon = "󱌣", icon_hl = "MiniIconsAzure" },
    ["neo-tree"] = { name = "explorer", icon = "󰙅", icon_hl = "Directory" },
    ["snacks_picker_input"] = { name = "picker", icon = "󰦨", icon_hl = "Changed" },
  }

  local fn_overrides = {
    ["lazygit"] = { icon = "", icon_hl = "Changed" },
    ["zsh"] = { icon = "", icon_hl = "Keyword" },
  }

  local ft = vim.bo.filetype
  if ft_overrides[ft] then
    return format_component(ft_overrides[ft].icon, ft_overrides[ft].icon_hl, " ", "")
      .. format_component(ft_overrides[ft].name, hl)
  end

  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  if filename == "" then
    return ""
  end

  local icon, icon_hl = "", "Comment"
  local ok, mini_icons = pcall(require, "mini.icons")
  if ok then
    icon, icon_hl = mini_icons.get("file", filename)
  end

  if fn_overrides[filename] then
    icon = fn_overrides[filename].icon
    icon_hl = fn_overrides[filename].icon_hl
  end

  return format_component(icon, icon_hl, " ", "") .. format_component(filename, hl)
end

M.progress = function(hl)
  return format_component("%2p%%", hl)
end

M.location = function(hl)
  return format_component("%l:%c", hl)
end

M.clock = function(hl)
  return format_component(os.date("%I:%M %p"):gsub("^0", ""), hl)
end

local components = {
  component("mode"),
  component("git_branch", "Changed"),
  component("git_diff", "Type"),
  component("diagnostics"),
  "%<",
  component("navic", "Comment"),
  "%=",
  component("status_messages"),
  component("lazy_updates", "String"),
  component("search_count", "Directory"),
  component("file_name", "Normal"),
  component("progress", "Special"),
  component("location", "Changed"),
  component("clock", "Conceal"),
}

M.statusline = table.concat(components, "")

return M
