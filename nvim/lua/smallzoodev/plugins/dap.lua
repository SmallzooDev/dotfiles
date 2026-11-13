return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
    },
    "theHamsta/nvim-dap-virtual-text",
    "leoluz/nvim-dap-go",
  },
  keys = {
    { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
    {
      "<leader>dg",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to cursor",
    },
    { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Condition: "))
      end,
      desc = "Conditional breakpoint",
    },
    { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step into" },
    { "<leader>do", "<cmd>DapStepOver<cr>", desc = "Step over" },
    { "<leader>dO", "<cmd>DapStepOut<cr>", desc = "Step out" },
    { "<leader>dt", "<cmd>DapTerminate<cr>", desc = "Terminate" },
    {
      "<leader>du",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle UI",
    },
    {
      "<leader>de",
      function()
        require("dapui").eval(nil, { enter = true })
      end,
      desc = "Evaluate",
      mode = { "n", "v" },
    },
    { "<leader>dr", "<cmd>DapToggleRepl<cr>", desc = "Toggle REPL" },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "Run last",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
    require("nvim-dap-virtual-text").setup()
    require("dap-go").setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    local function close()
      dapui.close({})
      pcall(function()
        require("nvim-dap-virtual-text.virtual_text").clear_virtual_text()
      end)
    end
    dap.listeners.before.event_terminated["dapui_config"] = close
    dap.listeners.before.event_exited["dapui_config"] = close

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "✗", texthl = "DiagnosticError", numhl = "" })
  end,
}
