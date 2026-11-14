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
      callback = function() pcall(resession.save, vim.fn.getcwd(), { notify = false }) end,
    })
  end,
}
