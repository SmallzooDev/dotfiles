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
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<leader>dg",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to cursor",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle breakpoint",
    },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Condition: "))
      end,
      desc = "Conditional breakpoint",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Step into",
    },
    {
      "<leader>do",
      function()
        require("dap").step_over()
      end,
      desc = "Step over",
    },
    {
      "<leader>dO",
      function()
        require("dap").step_out()
      end,
      desc = "Step out",
    },
    {
      "<leader>dt",
      function()
        require("dap").terminate()
      end,
      desc = "Terminate",
    },
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
    {
      "<leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle REPL",
    },
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
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
      pcall(function()
        require("nvim-dap-virtual-text.virtual_text").clear_virtual_text()
      end)
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
      pcall(function()
        require("nvim-dap-virtual-text.virtual_text").clear_virtual_text()
      end)
    end

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "✗", texthl = "DiagnosticError", numhl = "" })
  end,
}
