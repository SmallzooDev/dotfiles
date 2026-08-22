return {
  "saghen/blink.cmp",
  version = "*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = {
    keymap = {
      preset = "default",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-n>"] = { "show", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets" },
    },
    cmdline = { completion = { menu = { auto_show = true } } },
    completion = {
      menu = {
        scrollbar = false,
        auto_show = true,
        border = "single",
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind" } },
        },
      },
      list = {
        selection = {
          preselect = false,
        },
      },
      documentation = {
        auto_show = true,
        window = {
          border = "single",
        },
      },
    },
    signature = {
      enabled = true,
      window = { border = "single" },
    },
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    local function place_top_right(window)
      if not window:is_open() then
        return
      end

      window:update_size()
      local source_win = vim.api.nvim_get_current_win()
      local position = vim.api.nvim_win_get_position(source_win)
      vim.api.nvim_win_set_config(window:get_win(), {
        relative = "editor",
        anchor = "NE",
        row = position[1],
        col = position[2] + vim.api.nvim_win_get_width(source_win) - 1,
      })
    end

    local documentation = require("blink.cmp.completion.windows.documentation")
    documentation.update_position = function()
      place_top_right(documentation.win)
    end
    local signature = require("blink.cmp.signature.window")
    signature.update_position = function()
      place_top_right(signature.win)
    end
  end,
}
