-- Util: Init
-- https://github.com/smallzoo/vim-config

-- This is part of LazyVim's code, with my modifications.
-- See: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua

local LazyUtil = require('lazy.core.util')

---@class smallzoo.util: LazyUtilCore
---@field color smallzoo.util.color
---@field cmp smallzoo.util.cmp
---@field contextmenu smallzoo.util.contextmenu
---@field preview smallzoo.util.preview
---@field lualine smallzoo.util.lualine
local M = {}

---@type table<string, string|string[]>
local deprecated = {}

setmetatable(M, {
	__index = function(t, k)
		if LazyUtil[k] then
			return LazyUtil[k]
		end
		local dep = deprecated[k]
		if dep then
			local mod = type(dep) == 'table' and dep[1] or dep
			local key = type(dep) == 'table' and dep[2] or k
			M.deprecate(
				[[require("smallzoo.util").]] .. k,
				[[require("smallzoo.util").]] .. mod .. '.' .. key
			)
			t[mod] = require('smallzoo.util.' .. mod) -- load here to prevent loops
			return t[mod][key]
		end
		t[k] = require('smallzoo.util.' .. k)
		return t[k]
	end,
})

function M.deprecate(old, new)
	M.warn(('`%s` is deprecated. Please use `%s` instead'):format(old, new), {
		title = 'Smallzoo',
		once = true,
		stacktrace = true,
		stacklevel = 6,
	})
end

return M
