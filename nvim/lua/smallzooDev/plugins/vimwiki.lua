return {
	"vimwiki/vimwiki",
	priority = 999,
	init = function()
		vim.g.vimwiki_conceallevel = 0
		vim.g.vimwiki_global_ext = 0
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

		vim.g.vimwiki_syntax = "markdown"

		vim.g.vimwiki_primary_path = vim.g.vimwiki_list[1].path
		vim.g.vimwiki_secondary_path = vim.g.vimwiki_list[2].path

		vim.cmd([[
      let g:md_modify_disabled = 0

      function! NewTemplate()
        " 위키 경로가 설정된 변수로 변경
        let l:wiki_directory = v:false
        if expand('%:p:h') =~ expand(g:vimwiki_primary_path) || expand('%:p:h') =~ expand(g:vimwiki_secondary_path)
          let l:wiki_directory = v:true
        endif

        if !l:wiki_directory
          echom 'first debugging point >> called this return statement'
          return
        endif

        if line("$") > 1
          return
        endif

        let l:template = []
        call add(l:template, '---')
        call add(l:template, 'title: ')
        call add(l:template, 'summary: ')
        call add(l:template, 'date: ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
        call add(l:template, 'lastmod: ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
        call add(l:template, 'tags: ')
        call add(l:template, 'categories: ')
        call add(l:template, 'description: ')
        call add(l:template, 'showToc: true')
        call add(l:template, 'tocOpen: true')
        call add(l:template, '---')
        call add(l:template, '')
        call add(l:template, '# ')
        call setline(1, l:template)
        execute 'normal! G'
        execute 'normal! $'

        echom 'new wiki page has created'
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
        autocmd BufWritePre *wiki/*.md call LastModified()
        autocmd BufRead,BufNewFile *wiki/*.md call NewTemplate()
      augroup END
    ]])
	end,
}
