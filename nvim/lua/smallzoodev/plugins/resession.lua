return {
  "stevearc/resession.nvim",
  event = "VeryLazy",
  dependencies = {
    "scottmckendry/pick-resession.nvim",
  },
  opts = {
    autosave = {
      enabled = true,
      interval = 60,
      notify = false,
    },
  },
  keys = {
    {
      "<leader>fs",
      function()
        require("pick-resession").pick()
      end,
      desc = "Find Session",
    },
  },
  config = function(_, opts)
    local resession = require("resession")
    resession.setup(opts)
    vim.api.nvim_create_autocmd("VimLeavePre", {
      desc = "Save resession for cwd on exit",
      callback = function()
        local cwd, arg = vim.fn.getcwd(), vim.fn.argv(0)
        if arg ~= "" and not vim.fs.relpath(cwd, arg) then return end
        pcall(resession.save, cwd, { notify = false })
      end,
    })
  end,
}
