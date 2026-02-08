local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false

opt.conceallevel = 1

opt.undofile = true

opt.termguicolors = true

opt.showmode = false

opt.smoothscroll = true

opt.shortmess:append("sI")

opt.fillchars = { fold = " ", diff = "╱", eob = " " }

opt.updatetime = 250
opt.timeoutlen = 300
opt.ttimeoutlen = 10
opt.pumheight = 15 -- Limit completion menu height (reduces redraws)
