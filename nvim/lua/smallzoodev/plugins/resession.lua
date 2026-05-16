return {
  "stevearc/resession.nvim",
  lazy = false,
  opts = {
    autosave = {
      enabled = true,
      interval = 60,
      notify = false,
    },
  },
  keys = {
    {
      "<leader>ss",
      function()
        vim.ui.input({ prompt = "Session name: ", default = vim.fn.getcwd() }, function(name)
          if not name or name == "" then
            return
          end
          require("resession").save(name, { notify = true })
        end)
      end,
      desc = "Session: save (named)",
    },
    {
      "<leader>sl",
      function()
        local sessions = require("resession").list()
        if vim.tbl_isempty(sessions) then
          vim.notify("No saved sessions", vim.log.levels.WARN)
          return
        end
        vim.ui.select(sessions, { prompt = "Load session:" }, function(choice)
          if not choice then
            return
          end
          vim.schedule(function()
            pcall(require("resession").load, choice)
          end)
        end)
      end,
      desc = "Session: list & load",
    },
    {
      "<leader>sd",
      function()
        local cwd = vim.fn.getcwd()
        local ok = pcall(require("resession").delete, cwd)
        if ok then
          vim.notify("Deleted session: " .. cwd)
        else
          vim.notify("No session for: " .. cwd, vim.log.levels.WARN)
        end
      end,
      desc = "Session: delete (cwd)",
    },
  },
}
