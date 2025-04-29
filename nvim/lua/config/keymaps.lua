local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Insert Mode 커서 이동
keymap.set("i", "<C-f>", "<Esc>:let @z=@/<CR>/\\v[\\)\\\"\\}\\]]<CR>:let @/=@z<CR>:noh<CR>a", opts)
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

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

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
keymap.set("n", "gl", "1gtgT", opts)
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
