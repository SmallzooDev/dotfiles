return {
  "saghen/blink.cmp",
  version = "*",
  event = { "InsertEnter", "CmdlineEnter" },
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
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets" },
      providers = {
        path = {
          opts = {
            get_cwd = function(ctx)
              local dir = vim.fn.expand(("#%d:p:h"):format(ctx.bufnr))
              return vim.fn.resolve(dir) == vim.fn.resolve("/tmp") and vim.fn.getcwd() or dir
            end,
          },
        },
      },
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
}
