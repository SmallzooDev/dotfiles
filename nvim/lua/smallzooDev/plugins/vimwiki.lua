return {
	"vimwiki/vimwiki",
	priority = 999,
	init = function()
		vim.g.vimwiki_conceallevel = 0
		vim.g.vimwiki_global_ext = 0
		vim.g.vimwiki_markdown_link_ext = 0
		vim.g.vimwiki_folding = ""
		vim.g.vimwiki_key_mappings = {
			table_mappings = 0,
		}

		vim.keymap.set("n", "<leader>nl", "<Plug>VimwikiNextLink", { silent = true })
		vim.keymap.set("n", "<leader>pl", "<Plug>VimwikiPrevLink", { silent = true })

		vim.g.vimwiki_list = {
			{
				path = "/Users/joonkyu_kang/wiki/SmallzooDevWiki/content/_wiki",
				ext = ".md",
				index = "home",
			},
			{
				path = "/Users/joonkyu_kang/wiki/private_wiki",
				ext = ".md",
			},
		}

		vim.g.vimwiki_syntax = "default"

		vim.g.vimwiki_primary_path = vim.g.vimwiki_list[1].path
		vim.g.vimwiki_secondary_path = vim.g.vimwiki_list[2].path

		vim.cmd([[
      let g:md_modify_disabled = 0

      function! NewTemplate()
        " 경로 체크를 단순화
        let l:current_path = expand('%:p:h')
        if l:current_path !~ expand(g:vimwiki_primary_path) && l:current_path !~ expand(g:vimwiki_secondary_path)
          return
        endif

        if line("$") > 1
          return
        endif

        " 템플릿
        let l:template = [
          \ '---',
          \ 'title: ',
          \ 'summary: ',
          \ 'date: ' . strftime('%Y-%m-%d %H:%M:%S +0900'),
          \ 'lastmod: ' . strftime('%Y-%m-%d %H:%M:%S +0900'),
          \ 'tags: ',
          \ 'categories: ',
          \ 'description: ',
          \ 'showToc: true',
          \ 'tocOpen: true',
          \ '---',
          \ '',
          \ '# '
        \ ]
        call setline(1, l:template)
        normal! G$
      endfunction

      function! LastModified()
        if g:md_modify_disabled
          return
        endif
        if &modified
          let save_cursor = getpos(".")
          let n = min([10, line("$")])
          keepjumps exe '1,' . n . 's#^\(.\{,10}updated\s*: \).*#\1' .
                \ strftime('%Y-%m-%d %H:%M:%S +0900') . '#e'
          call histdel('search', -1)
          call setpos('.', save_cursor)
        endif
      endfunction

      augroup wimwikiauto
        autocmd!
        autocmd BufWritePre */SmallzooDevWiki/content/_wiki/*.md,*/private_wiki/*.md call LastModified()
        autocmd BufRead,BufNewFile */SmallzooDevWiki/content/_wiki/*.md,*/private_wiki/*.md call NewTemplate()
      augroup END
    ]])
	end,
}
