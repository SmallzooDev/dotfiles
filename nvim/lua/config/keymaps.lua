local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Insert Mode 커서 이동
-- keymap.set("i", "<C-f>", "<Esc>:let @z=@/<CR>/\\v[\\)\\\"\\}\\]]<CR>:let @/=@z<CR>:noh<CR>a", opts) -- Disabled for tmux prefix
keymap.set("i", "<C-b>", "<Esc>:let @z=@/<CR>?\\v[\\(\\\"\\{\\[]<CR>:let @/=@z<CR>:noh<CR>i", opts)
keymap.set("i", "<C-e>", "<C-o>A", opts)
keymap.set("i", "<C-a>", "<C-o>I", opts)

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Additional navigation
keymap.set("n", "H", "^", opts)
keymap.set("n", "L", "g_", opts)

-- Helix-style mappings
keymap.set("n", "gh", "0", opts)
keymap.set("n", "gl", "$", opts)
keymap.set("n", "gs", "^", opts)
keymap.set("n", "K", "i<CR><ESC>", opts)
keymap.set("n", "g;", "g;", opts)
keymap.set("n", "g,", "g,", opts)

-- Disable default mappings
keymap.set("n", "s", "<NOP>", opts)
keymap.set("n", "f", "<NOP>", opts)
keymap.set("n", "F", "<NOP>", opts)

-- Control-M mapping
keymap.set("n", "<C-m>", ":", opts)
keymap.set("v", "<C-m>", ":", opts)
-- keymap.set("i", "<C-m>", "<CR>", opts) -- Commented out: <C-m> is Enter key in terminal
-- keymap.set("c", "<C-m>", "<CR>", opts) -- This breaks auto-indentation

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window (matching IdeaVim)
keymap.set("n", "<leader>sh", ":split<Return>", opts)
keymap.set("n", "<leader>sv", ":vsplit<Return>", opts)
keymap.set("n", "<leader>su", ":close<Return>", opts)
keymap.set("n", "<leader>sm", "<C-w>r", opts)
keymap.set("n", "<leader>sb", "<C-o>", opts)
keymap.set("n", "<leader>sf", "<C-i>", opts)

-- Move window
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- 창 숨기기
keymap.set("n", "<leader>cw", ":hide<CR>", opts)

-- 페이지 이동
keymap.set("n", "<PageDown>", "gT", opts)
keymap.set("n", "<PageUp>", "gt", opts)
keymap.set("n", "gf", "1gt", opts)

-- 북마크 (Neovim 마크 시스템 사용)
for i = 0, 9 do
    keymap.set("n", "m" .. i, "m" .. i, opts)
    keymap.set("n", "`" .. i, "`" .. i, opts)
end

for c = string.byte('a'), string.byte('z') do
    local char = string.char(c)
    keymap.set("n", "m" .. char, "m" .. char, opts)
    keymap.set("n", "`" .. char, "`" .. char, opts)
end

-- IDE-like keymappings
keymap.set("n", "<leader>gR", vim.lsp.buf.references, { desc = "Show references" })
keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap.set("n", "<leader>gI", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap.set("n", "<Tab>d", vim.lsp.buf.hover, { desc = "Quick documentation" })
keymap.set("n", "<Tab>f", vim.lsp.buf.code_action, { desc = "Quick fixes" })
keymap.set("n", "<Tab>u", vim.lsp.buf.references, { desc = "Find usages" })
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap.set("n", "<leader>ll", vim.lsp.buf.code_action, { desc = "Code actions" })
keymap.set("n", "<Space>v", function() vim.fn.setreg('+', vim.fn.expand('%:p')) end, { desc = "Copy file path" })

-- Tab management keymappings from IdeaVim
keymap.set("n", "<Tab>oo", ":tabonly<CR>", { desc = "Close all tabs but active" })
keymap.set("n", "<Tab>ol", function()
  local current = vim.fn.tabpagenr()
  for i = current - 1, 1, -1 do
    vim.cmd("tabclose " .. i)
  end
end, { desc = "Close all tabs to the left" })
keymap.set("n", "<Tab>or", function()
  local current = vim.fn.tabpagenr()
  local total = vim.fn.tabpagenr('$')
  for i = total, current + 1, -1 do
    vim.cmd("tabclose " .. i)
  end
end, { desc = "Close all tabs to the right" })
keymap.set("n", "<Tab>i", ":lua vim.diagnostic.setloclist()<CR>", { desc = "Show diagnostics" })
keymap.set("n", "<Tab>,", ":e ~/.config/nvim/init.lua<CR>", { desc = "Edit nvim config" })

-- Method navigation
keymap.set({"n", "o"}, "[[", function()
  require("nvim-treesitter.textobjects.move").goto_previous_start("@function.outer")
end, { desc = "Previous method/function" })
keymap.set({"n", "o"}, "]]", function()
  require("nvim-treesitter.textobjects.move").goto_next_start("@function.outer")
end, { desc = "Next method/function" })

-- Terminal access
keymap.set("n", "<F3><F3>", ":terminal<CR>", { desc = "Open terminal" })

-- Structure/Outline view  
keymap.set("n", "<F1>t", ":Telescope treesitter<CR>", { desc = "Show file structure" })

-- File explorer focus
keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree sidebar" })
keymap.set("n", "<F1>f", ":Neotree reveal<CR>", { desc = "NERDTree find equivalent" })

-- LSP diagnostics toggle
keymap.set("n", "<leader>td", function()
  require("smallzoodev.lsp").toggleDiagnosticVirtualText()
end, { desc = "Toggle LSP diagnostic virtual text" })
