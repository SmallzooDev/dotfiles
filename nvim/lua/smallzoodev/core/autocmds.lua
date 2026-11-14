local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general = augroup("SmallzooGeneral", { clear = true })

autocmd("BufEnter", {
  group = general,
  desc = "Disable auto-comment on new line",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

autocmd("BufWinEnter", {
  group = general,
  desc = "Redirect help to floating window",
  callback = function(data)
    if vim.bo[data.buf].filetype ~= "help" or vim.bo[data.buf].modifiable then
      return
    end
    local help_win = vim.api.nvim_get_current_win()
    vim.api.nvim_open_win(data.buf, true, {
      relative = "editor",
      row = 0,
      col = vim.o.columns - 80,
      width = 80,
      height = vim.o.lines - 3,
    })
    vim.api.nvim_win_close(help_win, true)
  end,
})

autocmd("FileType", {
  group = general,
  pattern = { "help", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer",
    })
  end,
})

autocmd("BufEnter", {
  group = general,
  desc = "Auto chdir to project root (.git)",
  callback = vim.schedule_wrap(function(data)
    if data.buf ~= vim.api.nvim_get_current_buf() then
      return
    end
    local root = vim.fs.root(data.buf, ".git")
    if root == nil then
      return
    end
    vim.fn.chdir(root)
  end),
})
