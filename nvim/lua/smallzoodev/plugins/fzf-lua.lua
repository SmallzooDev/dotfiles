return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  keys = {
    { "<leader>f", function() require("fzf-lua").files() end, desc = "Find files" },
    { "<leader>F", function() require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Find files (buffer dir)" },
    { "<leader>b", function() require("fzf-lua").buffers() end, desc = "Find buffers" },
    { "<leader>/", function() require("fzf-lua").live_grep() end, desc = "Live grep" },
    { "<leader>?", function() require("fzf-lua").keymaps() end, desc = "Find keymaps" },
    { "<leader>'", function() require("fzf-lua").resume() end, desc = "Resume last picker" },
    { "<leader>d", function() require("fzf-lua").diagnostics_document() end, desc = "Document diagnostics" },
    { "<leader>D", function() require("fzf-lua").diagnostics_workspace() end, desc = "Workspace diagnostics" },
  },
  config = function()
    require("fzf-lua").setup({
      "telescope",
      winopts = {
        height = 0.85,
        width = 0.80,
        border = "rounded",
        preview = {
          border = "border",
          layout = "flex",
          flip_columns = 120,
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
      files = {
        formatter = "path.filename_first",
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
