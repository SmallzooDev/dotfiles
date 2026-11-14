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
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets" },
    },
    cmdline = { completion = { menu = { auto_show = true } } },
    completion = {
      menu = {
        scrollbar = false,
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
      },
    },
    signature = {
      enabled = true,
    },
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    local float = require("smallzoodev.core.float")
    for _, name in ipairs({ "blink.cmp.completion.windows.documentation", "blink.cmp.signature.window" }) do
      local module = require(name)
      module.update_position = function()
        if module.win:is_open() then
          module.win:update_size()
          float.top_right(module.win:get_win())
        end
      end
    end
  end,
}
