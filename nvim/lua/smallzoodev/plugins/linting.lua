return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      python = { "pylint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    local function try_linting()
      local linters = lint.linters_by_ft[vim.bo.filetype]
      lint.try_lint(linters)
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        if vim.bo.buftype ~= "" then
          return
        end
        try_linting()
      end,
    })

    vim.keymap.set("n", "<leader>ll", function()
      try_linting()
    end, { desc = "Trigger linting for current file" })
  end,
}
