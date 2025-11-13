return {
  dir = vim.fn.stdpath("config") .. "/colors",
  name = "overcast",
  priority = 1000,
  lazy = false,
  config = function()
    vim.opt.background = "light"
    vim.o.termguicolors = true
    vim.cmd.colorscheme("overcast")
  end,
}
