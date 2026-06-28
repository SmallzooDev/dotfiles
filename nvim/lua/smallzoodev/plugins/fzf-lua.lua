return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  cmd = "FzfLua",
  keys = {
    {
      "<leader>ff",
      function()
        require("fzf-lua").files()
      end,
      desc = "Find files",
    },
    {
      "<leader>fF",
      function()
        require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "Find files (buffer dir)",
    },
    {
      "<leader>fa",
      function()
        require("fzf-lua").files({ file_ignore_patterns = {} })
      end,
      desc = "Find files (incl. generated)",
    },
    {
      "<leader>fg",
      function()
        require("fzf-lua").live_grep({ file_ignore_patterns = {} })
      end,
      desc = "Live grep (incl. generated)",
    },
    {
      "<leader>b",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>/",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "Live grep",
    },
    {
      "<leader>?",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "Find keymaps",
    },
    {
      "<leader>'",
      function()
        require("fzf-lua").resume()
      end,
      desc = "Resume last picker",
    },
    {
      "<leader>fd",
      function()
        require("fzf-lua").diagnostics_document()
      end,
      desc = "Document diagnostics",
    },
    {
      "<leader>fD",
      function()
        require("fzf-lua").diagnostics_workspace()
      end,
      desc = "Workspace diagnostics",
    },
  },
  config = function()
    local fzf = require("fzf-lua")
    fzf.register_ui_select()

    local noise_patterns = {
      "mocks/",
      "__mocks__/",
      "_mock%.go",
      "mock_[^/]*%.go",
      "%.gen%.go",
      "%.pb%.go",
    }

    fzf.setup({
      "telescope",
      fzf_colors = true,
      fzf_opts = { ["--color"] = "bg:-1,gutter:-1,border:14" },
      hls = {
        normal = "Normal",
        border = "FloatBorder",
        preview_normal = "Normal",
        preview_border = "FloatBorder",
        title = "FloatTitle",
        preview_title = "FloatTitle",
      },
      winopts = {
        height = 0.85,
        width = 0.80,
        border = "rounded",
        preview = {
          border = "border",
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
