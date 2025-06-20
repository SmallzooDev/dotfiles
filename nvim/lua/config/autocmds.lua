-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Auto-reload files when changed externally
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Enable autoread
vim.o.autoread = true

-- Auto-reload files when changed externally
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  group = augroup("checktime"),
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Notification when file is reloaded
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  group = augroup("notify_file_change"),
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})

-- Prevent accidental data loss by prompting on conflicts
vim.api.nvim_create_autocmd({ "FileChangedShell" }, {
  group = augroup("notify_file_deleted"),
  callback = function()
    if vim.v.fcs_reason == "deleted" then
      vim.notify("File deleted on disk!", vim.log.levels.ERROR)
    end
  end,
})