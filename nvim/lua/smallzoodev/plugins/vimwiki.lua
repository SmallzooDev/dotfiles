return {
  "vimwiki/vimwiki",
  lazy = false,
  priority = 1000,
  init = function()
    vim.g.vimwiki_list = {
      {
        path = "~/vimwiki/",
        syntax = "markdown",
        ext = ".md",
      }
    }
    vim.g.vimwiki_global_ext = 0
  end,
  config = function()
    -- Force set the fucking mappings
    vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
      pattern = {"*.md", "*.wiki"},
      callback = function()
        local file_path = vim.fn.expand('%:p')
        if file_path:match("vimwiki") then
          -- Set filetype to vimwiki if in vimwiki folder
          vim.bo.filetype = "vimwiki"
          
          -- Force the fucking Enter key to work
          vim.keymap.set('n', '<CR>', ':VimwikiFollowLink<CR>', { buffer = true, silent = true })
          vim.keymap.set('n', '<S-CR>', ':VimwikiSplitLink<CR>', { buffer = true, silent = true })
          vim.keymap.set('n', '<Backspace>', ':VimwikiGoBackLink<CR>', { buffer = true, silent = true })
        end
      end,
    })
  end,
}