vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

keymap.set("x", "<", "<gv")
keymap.set("x", ">", ">gv")

keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

keymap.set("x", "p", '"_dP', { desc = "Paste without yanking" })

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

for _, name in ipairs({ "W", "Q", "Wq", "WQ", "Wa", "WA", "Qa", "QA", "Wqa", "WQa", "WQA", "Xa", "XA" }) do
  vim.api.nvim_create_user_command(name, name:lower(), { bang = true })
end

keymap.set({ "n", "v" }, "<F1>", "<Nop>")
keymap.set("i", "<F1>", "!")

keymap.set("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
  vim.wo.linebreak = vim.wo.wrap
end, { desc = "Toggle word wrap" })

-- Helix-like g mappings
keymap.set({ "n", "v" }, "gh", "0", { desc = "Go to start of line" })
keymap.set({ "n", "v" }, "gl", "$", { desc = "Go to end of line" })
keymap.set({ "n", "v" }, "gs", "^", { desc = "Go to first non-blank character" })

keymap.set("n", "U", "<C-r>", { desc = "Redo" })

keymap.set("n", "zf", "zc", { desc = "Fold block" })
keymap.set("n", "zu", "zo", { desc = "Unfold block" })
keymap.set("n", "zU", "zR", { desc = "Unfold all in buffer" })
