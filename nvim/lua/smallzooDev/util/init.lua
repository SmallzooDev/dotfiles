-- Util: Init
-- https://github.com/smallzooDev/vim-config

-- This is part of LazyVim's code, with my modifications.
-- See: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua

local LazyUtil = require('lazy.core.util')

---@class smallzooDev.util: LazyUtilCore
---@field color smallzooDev.util.color
---@field cmp smallzooDev.util.cmp
---@field contextmenu smallzooDev.util.contextmenu
---@field preview smallzooDev.util.preview
---@field lualine smallzooDev.util.lualine
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
				[[require("smallzooDev.util").]] .. k,
				[[require("smallzooDev.util").]] .. mod .. '.' .. key
			)
			t[mod] = require('smallzooDev.util.' .. mod) -- load here to prevent loops
			return t[mod][key]
		end
		t[k] = require('smallzooDev.util.' .. k)
		return t[k]
	end,
})

function M.deprecate(old, new)
	M.warn(('`%s` is deprecated. Please use `%s` instead'):format(old, new), {
		title = 'smallzooDev',
		once = true,
		stacktrace = true,
		stacklevel = 6,
	})
end

return M
