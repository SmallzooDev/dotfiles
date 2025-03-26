return {
	"github/copilot.vim",
	lazy = true,
	config = function()
		local copilot = {
			enabled = false,
		}

		local function enable()
			if not copilot.enabled then
				copilot.enabled = true
				vim.cmd("Copilot enable")
				print("Copilot Enabled")
			end
		end

		local function disable()
			if copilot.enabled then
				copilot.enabled = false
				vim.cmd("Copilot disable")
				print("Copilot Disabled")
			end
		end

		local function toggle()
			if copilot.enabled then
				disable()
			else
				enable()
			end
		end

		vim.api.nvim_create_user_command("EnableCopilot", enable, { desc = "Enable GitHub Copilot" })
		vim.api.nvim_create_user_command("DisableCopilot", disable, { desc = "Disable GitHub Copilot" })

		vim.keymap.set("n", "<leader>cp", toggle, { desc = "Toggle Copilot", silent = true })
	end,
}
