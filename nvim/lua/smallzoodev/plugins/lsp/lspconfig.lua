return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  opts = { servers = {} },
  config = function(_, opts)
    local float = require("smallzoodev.core.float")
    local open_floating_preview = vim.lsp.util.open_floating_preview
    vim.lsp.util.open_floating_preview = function(...)
      local float_buf, float_win = open_floating_preview(...)
      if float_win ~= vim.api.nvim_get_current_win() then
        float.top_right(float_win)
      end
      return float_buf, float_win
    end

    vim.diagnostic.config({
      underline = false,
      virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "✗",
          [vim.diagnostic.severity.WARN] = "➜",
          [vim.diagnostic.severity.HINT] = "➜",
          [vim.diagnostic.severity.INFO] = "➜",
        },
      },
      severity_sort = true,
      float = { source = true },
    })

    for _, defkey in ipairs({ "grn", "gra", "grr", "gri", "grt", "grx" }) do
      pcall(vim.keymap.del, "n", defkey)
    end
    pcall(vim.keymap.del, "x", "gra")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end
        local function toggle(feature)
          return function() feature.enable(not feature.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf }) end
        end

        map("n", "gr", "<cmd>FzfLua lsp_references<CR>", "Show LSP references")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", "Show LSP definitions")
        map("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", "Show LSP implementations")
        map("n", "gI", function() vim.lsp.buf.typehierarchy("supertypes") end, "Go to interface / supertype")
        map("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", "Show LSP type definitions")
        map({ "n", "v" }, "<leader>a", "<cmd>FzfLua lsp_code_actions<CR>", "Code actions")
        map("n", "<leader>r", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>k", vim.lsp.buf.hover, "Hover documentation")

        map("n", "<leader>s", function()
          local ok, aerial = pcall(require, "aerial")
          if ok then
            aerial.fzf_lua_picker()
          else
            vim.cmd("FzfLua lsp_document_symbols")
          end
        end, "Document symbols (aerial)")
        map("n", "<leader>S", "<cmd>FzfLua lsp_workspace_symbols<CR>", "Workspace symbols")

        map("n", "<leader>lR", "<cmd>lsp restart<CR>", "Restart LSP")
        map("n", "<leader>ll", function()
          local path = vim.lsp.log.get_filename()
          vim.cmd.edit(vim.fn.fnameescape(path))
        end, "Open LSP log")
        map("n", "<leader>li", "<cmd>checkhealth lsp<CR>", "LSP info")

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.name == "gopls" then
          client.server_capabilities.semanticTokensProvider = nil
        end
        if client and client:supports_method("textDocument/codeLens", ev.buf) then
          map("n", "<leader>lc", vim.lsp.codelens.run, "Run codelens on current line")
          map("n", "<leader>lL", toggle(vim.lsp.codelens), "Toggle codelens")
        end

        map("n", "<leader>lh", toggle(vim.lsp.inlay_hint), "Toggle inlay hints")
        map("n", "<leader>ld", vim.diagnostic.open_float, "Show line diagnostic")
      end,
    })

    for name, server in pairs(opts.servers) do
      vim.lsp.config(name, server)
    end
    vim.lsp.enable(vim.tbl_keys(opts.servers))
  end,
}
