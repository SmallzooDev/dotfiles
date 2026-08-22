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
}
