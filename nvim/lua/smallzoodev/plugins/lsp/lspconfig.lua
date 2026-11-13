return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Set this to false to restore Neovim's cursor-relative LSP floats.
    local top_right_lsp_floats = true

    local function place_float_top_right(float_win, source_win)
      if
        not top_right_lsp_floats
        or not float_win
        or not source_win
        or not vim.api.nvim_win_is_valid(float_win)
        or not vim.api.nvim_win_is_valid(source_win)
      then
        return
      end

      local position = vim.api.nvim_win_get_position(source_win)
      vim.api.nvim_win_set_config(float_win, {
        relative = "editor",
        anchor = "NE",
        row = position[1],
        col = position[2] + vim.api.nvim_win_get_width(source_win) - 1,
      })
    end

    local open_floating_preview = vim.lsp.util.open_floating_preview
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
      local float_buf, float_win = open_floating_preview(contents, syntax, opts)
      vim.api.nvim_set_option_value("conceallevel", 2, { win = float_win })
      vim.api.nvim_set_option_value("concealcursor", "", { win = float_win })
      place_float_top_right(float_win, (opts and opts._top_right_win) or vim.api.nvim_get_current_win())
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
        map("n", "<leader>k", function()
          local source_win = vim.api.nvim_get_current_win()
          vim.lsp.buf.hover(top_right_lsp_floats and { _top_right_win = source_win } or nil)
        end, "Hover documentation")

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
        map("n", "<leader>ll", function() vim.cmd.edit(vim.fn.fnameescape(vim.lsp.get_log_path())) end, "Open LSP log")
        map("n", "<leader>li", "<cmd>checkhealth lsp<CR>", "LSP info")

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.name == "gopls" then
          client.server_capabilities.semanticTokensProvider = nil
        end
        if client and client:supports_method("textDocument/codeLens", ev.buf) then
          map("n", "<leader>lc", vim.lsp.codelens.run, "Run codelens on current line")
          map("n", "<leader>lC", vim.lsp.codelens.refresh, "Refresh codelens")
          map("n", "<leader>lL", toggle(vim.lsp.codelens), "Toggle codelens")
        end

        map("n", "<leader>lh", toggle(vim.lsp.inlay_hint), "Toggle inlay hints")
        map("n", "<leader>ld", function()
          if #vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 }) == 0 then
            return
          end
          local source_win = vim.api.nvim_get_current_win()
          local _, float_win = vim.diagnostic.open_float({ scope = "line" })
          place_float_top_right(float_win, source_win)
        end, "Show line diagnostic")
      end,
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
          hint = {
            enable = true,
            arrayIndex = "Disable",
            setType = true,
          },
        },
      },
    })

    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          usePlaceholders = true,
          staticcheck = true,
          semanticTokens = false,
          directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-**/node_modules" },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            features = "all",
          },
          check = {
            command = "clippy",
          },
          inlayHints = {
            closingBraceHints = { minLines = 10 },
          },
        },
      },
    })

    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
      },
    })

    vim.lsp.enable({ "lua_ls", "gopls", "pyright", "rust_analyzer", "clangd" })
  end,
}
