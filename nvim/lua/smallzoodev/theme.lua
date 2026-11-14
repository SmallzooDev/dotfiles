local dir = vim.fn.stdpath("config") .. "/../colorscheme"
local themes = dofile(dir .. "/themes.lua")

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("SmallzoodevCursorColor", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "Cursor", { fg = "bg", bg = "fg" })
    vim.api.nvim_set_hl(0, "lCursor", { link = "Cursor" })
  end,
})

local applied
local function apply()
  local name = vim.fn.fnamemodify(vim.fn.resolve(dir .. "/current"), ":t")
  if name == applied then
    return
  end
  applied = name
  vim.cmd.colorscheme((themes[name] or themes["rose-pine"]).nvim)
end

apply()

vim.api.nvim_create_autocmd("FocusGained", {
  group = vim.api.nvim_create_augroup("SmallzoodevThemeFollow", { clear = true }),
  nested = true,
  callback = apply,
})
