-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

-- C/C++ 관련 설정
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		-- 탭 설정
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
		
		-- 줄 길이 및 경고선
		vim.opt_local.textwidth = 100
		vim.opt_local.colorcolumn = "100"
	end,
})

-- clang-format 자동 포맷 설정
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.c", "*.h", "*.cpp", "*.hpp", "*.cc", "*.hh" },
	callback = function()
		-- 현재 버퍼에 formatter가 있는 경우에만 실행
		if vim.fn.exists(":Format") > 0 then
			vim.cmd("Format")
		end
	end,
})
