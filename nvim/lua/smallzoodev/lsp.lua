local M = {}
local LazyvimUtil = require("lazyvim.util")

function M.toggleInlayHints()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

function M.toggleAutoformat()
	LazyvimUtil.format.toggle()
end

function M.toggleDiagnosticVirtualText()
	local current = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({
		virtual_text = not current,
	})
end

return M
