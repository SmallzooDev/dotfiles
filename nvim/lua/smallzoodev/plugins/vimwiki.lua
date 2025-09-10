return {
  "vimwiki/vimwiki",
  cmd = "VimwikiIndex",
  init = function()
    vim.g.vimwiki_list = {{
      path = '~/vimwiki/',
      syntax = 'markdown',
      ext = '.md',
      custom_wiki2html = 'vimwiki_markdown',
      html_filename_parameterization = 1,
    }}
    vim.g.vimwiki_global_ext = 0
    vim.g.vimwiki_markdown_link_ext = 1  -- Add .md extension to links
    vim.g.vimwiki_conceallevel = 2  -- Conceal link URLs for cleaner look
    vim.g.vimwiki_url_maxsave = 0  -- Don't shorten URLs
    vim.g.vimwiki_listsyms = '✗○◐●✓'  -- Better checkbox symbols
    -- Disable default mappings that conflict
    vim.g.vimwiki_key_mappings = { table_mappings = 0, lists_return = 0 }
  end,
  keys = {
    { "<leader>ww", "<cmd>VimwikiIndex<CR>", desc = "Open wiki" },
    { "<leader>wi", "<cmd>VimwikiDiaryIndex<CR>", desc = "Open diary" },
    { "<leader>w<leader>w", "<cmd>VimwikiMakeDiaryNote<CR>", desc = "Today's diary" },
    { "<leader>wt", "<cmd>VimwikiTabIndex<CR>", desc = "Wiki in tab" },
    { "<leader>wc", "<cmd>VimwikiToggleListItem<CR>", desc = "Toggle checkbox" },
  },
  config = function()
    -- Better link concealing and highlighting
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "vimwiki",
      callback = function()
        vim.opt_local.conceallevel = 2  -- Hide URLs, show link text
        vim.opt_local.concealcursor = "nc"  -- Show URL when cursor is on the line in insert mode
        
        -- Custom highlights for better visibility
        vim.cmd([[
          hi VimwikiLink guifg=#61afef ctermfg=75
          hi VimwikiHeaderChar guifg=#e06c75 ctermfg=167
          hi VimwikiHeader1 guifg=#e06c75 gui=bold
          hi VimwikiHeader2 guifg=#e5c07b gui=bold
          hi VimwikiHeader3 guifg=#98c379 gui=bold
        ]])
      end,
    })
  end,
}