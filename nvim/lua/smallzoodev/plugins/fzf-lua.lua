return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
    {
      "<leader>fF",
      function() require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") }) end,
      desc = "Find files (buffer dir)",
    },
    {
      "<leader>fa",
      function() require("fzf-lua").files({ file_ignore_patterns = {}, no_ignore = true }) end,
      desc = "Find files (incl. generated, gitignored)",
    },
    {
      "<leader>fg",
      function() require("fzf-lua").live_grep({ file_ignore_patterns = {}, no_ignore = true }) end,
      desc = "Live grep (incl. generated, gitignored)",
    },
    { "<leader>b", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
    { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
    { "<leader>?", "<cmd>FzfLua keymaps<cr>", desc = "Find keymaps" },
    { "<leader>'", "<cmd>FzfLua resume<cr>", desc = "Resume last picker" },
    { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
    { "<leader>fD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
  },
  config = function()
    local fzf = require("fzf-lua")

    local noise_patterns = {
      "mocks/",
      "__mocks__/",
      "_mock%.go",
      "mock_[^/]*%.go",
      "%.gen%.go",
      "%.pb%.go",
    }

    fzf.setup({
      file_icons = false,
      color_icons = false,
      winopts = {
        height = 0.85,
        width = 0.80,
        backdrop = 100,
        border = "single",
        preview = {
          border = "single",
          layout = "flex",
          flip_columns = 120,
          winopts = { number = false },
        },
      },
      keymap = {
        builtin = {
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
          ["<C-t>"] = "toggle-preview",
        },
        fzf = {
          ["ctrl-j"] = "down",
          ["ctrl-k"] = "up",
          ["ctrl-d"] = "preview-page-down",
          ["ctrl-u"] = "preview-page-up",
          ["ctrl-q"] = "select-all+accept",
        },
      },
      file_ignore_patterns = noise_patterns,
      files = {
        formatter = "path.filename_first",
      },
      grep = {
        hls = { search = false },
      },
      buffers = {
        actions = {
          ["ctrl-d"] = false,
        },
      },
      lsp = {
        async_or_timeout = 5000,
        code_actions = {
          previewer = "codeaction_native",
        },
      },
    })
  end,
}
