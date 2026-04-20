vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })

keymap.set("n", "yp", function()
  local filepath = vim.fn.expand("%:~")
  local line_number = vim.fn.line(".")
  local text = filepath .. ":" .. line_number
  vim.fn.setreg("+", text)
  print("Copied: " .. text)
end, { desc = "Copy file path with line number" })

keymap.set("n", "gp", function()
  local clipboard = vim.trim(vim.fn.getreg("+"))
  local input = clipboard

  if clipboard == "" or clipboard:match("^%s*$") then
    input = vim.fn.input("Go to (file or file:line): ", "", "file")
    if input == "" then
      return
    end
  end

  local file, line = input:match("^(.+):(%d+)$")
  if not file then
    file = input
    line = nil
  end

  file = vim.fn.fnamemodify(file, ":p")
  vim.cmd("edit " .. vim.fn.fnameescape(file))

  if line then
    vim.cmd(line)
    vim.cmd("normal! zz")
    print("Jumped to " .. file .. ":" .. line)
  else
    print("Opened " .. file)
  end
end, { desc = "Go to file:line from clipboard or input" })

local cmd_aliases = {
  { "W", "w" },
  { "Q", "q" },
  { "Wq", "wq" },
  { "WQ", "wq" },
  { "Wa", "wa" },
  { "WA", "wa" },
  { "Qa", "qa" },
  { "QA", "qa" },
  { "Wqa", "wqa" },
  { "WQa", "wqa" },
  { "WQA", "wqa" },
  { "Xa", "xa" },
  { "XA", "xa" },
}

for _, alias in ipairs(cmd_aliases) do
  vim.api.nvim_create_user_command(alias[1], alias[2], { bang = true })
end

keymap.set({ "n", "v" }, "<F1>", "<Nop>")
keymap.set("i", "<F1>", "!")

keymap.set("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
  vim.wo.linebreak = vim.wo.wrap
  vim.wo.breakindent = vim.wo.wrap
  vim.wo.showbreak = vim.wo.wrap and "↪ " or ""
  vim.wo.breakindentopt = vim.wo.wrap and "shift:2" or ""
end, { desc = "Toggle word wrap" })

-- Helix-like g mappings
keymap.set({ "n", "v" }, "gh", "0", { desc = "Go to start of line" })
keymap.set({ "n", "v" }, "gl", "$", { desc = "Go to end of line" })
keymap.set({ "n", "v" }, "gs", "^", { desc = "Go to first non-blank character" })

keymap.set("n", "U", "<C-r>", { desc = "Redo" })

local reload_aug = vim.api.nvim_create_augroup("Reload", { clear = true })

local function reload_notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "Reload" })
end

local function pick_conflict_action(file, on_choice)
  local items = {
    { label = "Load disk  (discard local edits)", action = "load" },
    { label = "Keep local (ignore disk)", action = "keep" },
    { label = "Diff       (vert split, manual)", action = "diff" },
  }
  local width = 42
  local buf = vim.api.nvim_create_buf(false, true)
  local lines = {}
  for _, it in ipairs(items) do
    table.insert(lines, " " .. it.label)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = #items,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - #items) / 2),
    border = "rounded",
    title = " Conflict: " .. vim.fn.fnamemodify(file, ":t") .. " ",
    title_pos = "center",
    style = "minimal",
  })
  vim.wo[win].cursorline = true

  local function move(dir)
    local row = vim.api.nvim_win_get_cursor(win)[1]
    vim.api.nvim_win_set_cursor(win, { math.max(1, math.min(#items, row + dir)), 0 })
  end

  local function close_with(action)
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    on_choice(action)
  end

  local kopts = { buffer = buf, silent = true, nowait = true }
  vim.keymap.set("n", "j", function() move(1) end, kopts)
  vim.keymap.set("n", "k", function() move(-1) end, kopts)
  vim.keymap.set("n", "<Down>", function() move(1) end, kopts)
  vim.keymap.set("n", "<Up>", function() move(-1) end, kopts)
  vim.keymap.set("n", "<CR>", function()
    local row = vim.api.nvim_win_get_cursor(win)[1]
    close_with(items[row].action)
  end, kopts)
  vim.keymap.set("n", "<Esc>", function() close_with("keep") end, kopts)
  vim.keymap.set("n", "q", function() close_with("keep") end, kopts)
  vim.keymap.set("n", "<C-r>", "<nop>", kopts)
end

vim.api.nvim_create_autocmd("FileChangedShell", {
  group = reload_aug,
  callback = function(args)
    local reason = vim.v.fcs_reason
    local buf = args.buf
    local file = args.file

    if reason == "deleted" then
      reload_notify(("deleted on disk (buffer kept): %s"):format(file), vim.log.levels.WARN)
      vim.v.fcs_choice = ""
      return
    end
    if reason == "mode" or reason == "time" then
      vim.v.fcs_choice = ""
      return
    end
    if not vim.bo[buf].modified then
      vim.v.fcs_choice = "reload"
      return
    end

    vim.v.fcs_choice = ""
    vim.schedule(function()
      pick_conflict_action(file, function(action)
        if action == "load" then
          vim.api.nvim_buf_call(buf, function() vim.cmd("edit!") end)
          reload_notify(("loaded from disk: %s"):format(vim.fn.fnamemodify(file, ":~:.")))
        elseif action == "diff" then
          vim.api.nvim_buf_call(buf, function()
            vim.cmd("vert diffsplit " .. vim.fn.fnameescape(file))
          end)
        end
      end)
    end)
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

keymap.set("n", "<C-r>", function()
  vim.cmd("checktime")
  local clients = vim.lsp.get_clients()
  if #clients > 0 then
    vim.cmd("LspRestart")
  end
  reload_notify(("checked all buffers, restarted %d LSP client(s)"):format(#clients))
end, { desc = "Reload all buffers + restart LSP" })
