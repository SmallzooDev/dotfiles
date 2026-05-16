local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local utils = require("smallzoodev.core.utils")

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
    utils.open_help(data.buf)
  end,
})

autocmd("FileType", {
  group = general,
  pattern = { "help", "checkhealth", "grug-far" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer",
    })
  end,
})

autocmd("VimLeavePre", {
  group = general,
  desc = "Save resession for cwd on exit",
  callback = function()
    local ok, resession = pcall(require, "resession")
    if not ok then
      return
    end
    pcall(resession.save, vim.fn.getcwd(), { notify = false })
  end,
})

autocmd("BufEnter", {
  group = general,
  nested = true,
  desc = "Auto chdir to project root (.git)",
  callback = vim.schedule_wrap(function(data)
    if data.buf ~= vim.api.nvim_get_current_buf() then
      return
    end
    local root = utils.find_root(data.buf, { ".git" })
    if root == nil then
      return
    end
    vim.fn.chdir(root)
  end),
})
