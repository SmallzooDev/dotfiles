return {
  -- Auto-reload files when changed externally
  {
    "config",
    event = "VeryLazy",
    config = function()
      -- Enable autoread
      vim.o.autoread = true

      -- Auto-reload files when changed externally
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
        command = "if mode() != 'c' | checktime | endif",
        pattern = { "*" },
      })

      -- Notification when file is reloaded
      vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
        callback = function()
          vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
        end,
      })

      -- Prevent accidental data loss by prompting on conflicts
      vim.api.nvim_create_autocmd({ "FileChangedShell" }, {
        callback = function()
          if vim.v.fcs_reason == "deleted" then
            vim.notify("File deleted on disk!", vim.log.levels.ERROR)
          end
        end,
      })
    end,
  },
}