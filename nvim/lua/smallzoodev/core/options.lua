local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.breakindent = true
opt.breakindentopt = "shift:2"
opt.showbreak = "↳"

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = false
opt.scrolloff = 12

opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false

opt.conceallevel = 1

opt.undofile = true

opt.termguicolors = true
opt.winborder = "single"

opt.showmode = false
opt.laststatus = 3

opt.smoothscroll = true

opt.shortmess:append("sI")

opt.fillchars = { fold = " ", diff = "╱", eob = " " }

opt.foldmethod = "manual"

opt.updatetime = 250
opt.timeoutlen = 300
opt.ttimeoutlen = 10
opt.pumheight = 15

opt.title = true
opt.titlestring = string.format(
  "%s@%s - nvim %%t",
  os.getenv("USERNAME") or os.getenv("USER") or "nvim",
  vim.fn.hostname()
)

opt.guicursor = {
  "n-c:block,i-ci:ver25,v-ve:hor20,r-cr:hor20,o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

opt.statusline = require("smallzoodev.core.statusline").statusline

vim.g.omni_sql_no_default_maps = 1
