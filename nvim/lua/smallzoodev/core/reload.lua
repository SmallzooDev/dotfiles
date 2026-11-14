local reload_aug = vim.api.nvim_create_augroup("Reload", { clear = true })

local function reload_notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "Reload" })
end

local function load_disk(buf, file)
  if not vim.api.nvim_buf_is_valid(buf) then return end
  vim.api.nvim_buf_call(buf, function() vim.cmd("edit!") end)
  reload_notify(("loaded from disk: %s"):format(vim.fn.fnamemodify(file, ":~:.")))
end

local function open_diff_scratch(buf, file)
  if not vim.api.nvim_buf_is_valid(buf) then return end
  local ok, disk_lines = pcall(vim.fn.readfile, file)
  if not ok then
    reload_notify("failed to read disk file: " .. file, vim.log.levels.ERROR)
    return
  end
  local wins = vim.fn.win_findbuf(buf)
  if #wins == 0 then
    reload_notify("original buffer not visible", vim.log.levels.WARN)
    return
  end
  vim.api.nvim_set_current_win(wins[1])
  vim.cmd("diffthis")
  vim.cmd("vnew")
  local nbuf = vim.api.nvim_get_current_buf()
  vim.bo[nbuf].buftype = "nofile"
  vim.bo[nbuf].bufhidden = "wipe"
  vim.bo[nbuf].swapfile = false
  vim.api.nvim_buf_set_lines(nbuf, 0, -1, false, disk_lines)
  vim.bo[nbuf].modifiable = false
  local ft = vim.bo[buf].filetype
  if ft and ft ~= "" then
    vim.bo[nbuf].filetype = ft
  end
  pcall(vim.api.nvim_buf_set_name, nbuf, "disk://" .. vim.fn.fnamemodify(file, ":t"))
  vim.cmd("diffthis")
  vim.cmd("wincmd p")
end

local conflict_actions = {
  { label = "Load disk  (discard local edits)", run = load_disk },
  { label = "Keep local (ignore disk)" },
  { label = "Diff       (scratch split, manual)", run = open_diff_scratch },
}
local conflict_queue = {}
local conflict_total = 0

local function process_next_conflict()
  local entry = table.remove(conflict_queue, 1)
  if not entry then
    conflict_total = 0
    return
  end
  local index = conflict_total - #conflict_queue
  local title = ("Conflict (%d/%d): %s"):format(index, conflict_total, vim.fn.fnamemodify(entry.file, ":t"))
  local opts = { prompt = title, format_item = function(action) return action.label end }
  vim.ui.select(conflict_actions, opts, function(action)
    if action and action.run then
      action.run(entry.buf, entry.file)
    end
    vim.schedule(process_next_conflict)
  end)
end

vim.api.nvim_create_autocmd("FileChangedShell", {
  group = reload_aug,
  callback = function(args)
    if vim.v.fcs_reason == "deleted" then
      reload_notify(("deleted on disk (buffer kept): %s"):format(args.file), vim.log.levels.WARN)
      return
    end
    table.insert(conflict_queue, { buf = args.buf, file = args.file })
    conflict_total = conflict_total + 1
    if conflict_total == 1 then
      vim.schedule(process_next_conflict)
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = reload_aug,
  callback = function(args)
    if not vim.bo[args.buf].modified then
      reload_notify(("reloaded: %s"):format(vim.fn.fnamemodify(args.file, ":~:.")))
    end
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermClose", "TermLeave", "CursorHold" }, {
  group = reload_aug,
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("silent! checktime")
    end
  end,
})

vim.keymap.set("n", "<C-r>", function()
  vim.cmd("checktime")
  local clients = vim.lsp.get_clients()
  if #clients > 0 then
    vim.cmd("lsp restart")
  end
  reload_notify(("checked all buffers, restarted %d LSP client(s)"):format(#clients))
end, { desc = "Reload all buffers + restart LSP" })
