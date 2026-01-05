vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>ss", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" })

for i = 1, 9 do
  keymap.set("n", "<leader>" .. i, function()
    vim.cmd("tabn " .. i)
  end, { desc = "Go to tab " .. i })
end

keymap.set("n", "<leader>tmh", "<cmd>-tabmove<CR>", { desc = "Move tab left" })
keymap.set("n", "<leader>tml", "<cmd>+tabmove<CR>", { desc = "Move tab right" })

keymap.set("n", "<leader>tl", function()
  local tabs = vim.api.nvim_list_tabpages()
  local tab_info = {}

  for i, tab in ipairs(tabs) do
    local wins = vim.api.nvim_tabpage_list_wins(tab)
    local bufs = {}

    for _, win in ipairs(wins) do
      local buf = vim.api.nvim_win_get_buf(win)
      local bufname = vim.api.nvim_buf_get_name(buf)
      if bufname ~= "" then
        table.insert(bufs, vim.fn.fnamemodify(bufname, ":t"))
      end
    end

    local current = vim.api.nvim_get_current_tabpage() == tab and " [current]" or ""
    local display = string.format("Tab %d: %s%s", i, table.concat(bufs, ", "), current)

    table.insert(tab_info, {
      display = display,
      tab_nr = i,
    })
  end

  vim.ui.select(tab_info, {
    prompt = "Select tab:",
    format_item = function(item)
      return item.display
    end,
  }, function(choice)
    if choice then
      vim.cmd("tabn " .. choice.tab_nr)
    end
  end)
end, { desc = "List and select tabs" })

keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

keymap.set("n", "<M-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<M-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<M-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<M-l>", "<C-w>l", { desc = "Go to right window" })

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
  local clipboard = vim.fn.getreg("+")
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

  file = vim.fn.expand(file)
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

-- Helix-like g mappings
keymap.set({ "n", "v" }, "gh", "0", { desc = "Go to start of line" })
keymap.set({ "n", "v" }, "gl", "$", { desc = "Go to end of line" })
keymap.set({ "n", "v" }, "gs", "^", { desc = "Go to first non-blank character" })
