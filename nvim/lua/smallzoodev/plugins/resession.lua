return {
  "stevearc/resession.nvim",
  lazy = false,
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
}
