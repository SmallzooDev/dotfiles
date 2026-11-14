local M = {}

function M.top_right(win)
  local source = vim.api.nvim_get_current_win()
  local position = vim.api.nvim_win_get_position(source)
  vim.api.nvim_win_set_config(win, {
    relative = "editor",
    anchor = "NE",
    row = position[1],
    col = position[2] + vim.api.nvim_win_get_width(source) - 1,
  })
end

return M
