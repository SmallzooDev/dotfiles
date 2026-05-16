local M = {}

--- Get the number of listed (non-nofile) buffers
--- @return number
function M.get_buffer_count()
  local count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buflisted and vim.bo[buf].buftype ~= "nofile" then
      count = count + 1
    end
  end
  return count
end

--- Switch to the alternate buffer; fall back to bprevious when none.
function M.switch_to_other_buffer()
  local ok = pcall(vim.cmd, "buffer #")
  if ok then
    return
  end
  if M.get_buffer_count() > 1 then
    vim.cmd("bprevious")
    return
  end
  vim.notify("No other buffer to switch to!", vim.log.levels.WARN)
end

--- Find project root by searching upward for marker files.
--- @param buf number
--- @param names table|function marker file/dir names
--- @return string|nil
function M.find_root(buf, names)
  local path = vim.api.nvim_buf_get_name(buf)
  if path == "" then
    return nil
  end
  local dir = vim.fn.fnamemodify(path, ":p:h")
  if dir == "" then
    return nil
  end
  return vim.fs.root(dir, names) or nil
end

--- Open the help buffer in a floating window on the right.
--- @param buf number
function M.open_help(buf)
  if buf == nil then
    return
  end
  if vim.bo[buf].filetype ~= "help" or vim.bo[buf].modifiable then
    return
  end
  local help_win = vim.api.nvim_get_current_win()
  local new_win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = 0,
    col = vim.o.columns - 80,
    width = 80,
    height = vim.o.lines - 3,
    border = "rounded",
  })
  vim.wo[help_win].scroll = vim.wo[new_win].scroll
  vim.api.nvim_win_close(help_win, true)
end

return M
