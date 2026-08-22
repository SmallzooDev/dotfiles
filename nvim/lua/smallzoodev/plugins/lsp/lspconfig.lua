return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
  },
  config = function()
    local keymap = vim.keymap

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
      float = { border = "single", source = true },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        for _, defkey in ipairs({ "grn", "gra", "grr", "gri", "grt", "grx" }) do
          pcall(vim.keymap.del, "n", defkey)
        end
        pcall(vim.keymap.del, "x", "gra")

        keymap.set(
          "n",
          "gr",
          "<cmd>FzfLua lsp_references<CR>",
          vim.tbl_extend("force", opts, { desc = "Show LSP references" })
        )
        keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
        keymap.set(
          "n",
          "gd",
          "<cmd>FzfLua lsp_definitions<CR>",
          vim.tbl_extend("force", opts, { desc = "Show LSP definitions" })
        )
        keymap.set(
          "n",
          "gi",
          "<cmd>FzfLua lsp_implementations<CR>",
          vim.tbl_extend("force", opts, { desc = "Show LSP implementations" })
        )
        keymap.set("n", "gI", function()
          vim.lsp.buf.typehierarchy("supertypes")
        end, vim.tbl_extend("force", opts, { desc = "Go to interface / supertype" }))
        keymap.set(
          "n",
          "gt",
          "<cmd>FzfLua lsp_typedefs<CR>",
          vim.tbl_extend("force", opts, { desc = "Show LSP type definitions" })
        )
        keymap.set(
          { "n", "v" },
          "<leader>a",
          "<cmd>FzfLua lsp_code_actions<CR>",
          vim.tbl_extend("force", opts, { desc = "Code actions" })
        )
        keymap.set("n", "<leader>r", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
        keymap.set("n", "<leader>k", function()
          vim.lsp.buf.hover(top_right_lsp_floats and { _top_right_win = vim.api.nvim_get_current_win() } or nil)
        end, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))

        keymap.set("n", "<leader>s", function()
          local ok, aerial = pcall(require, "aerial")
          if ok then
            aerial.fzf_lua_picker()
          else
            vim.cmd("FzfLua lsp_document_symbols")
          end
        end, vim.tbl_extend("force", opts, { desc = "Document symbols (aerial)" }))
        keymap.set(
          "n",
          "<leader>S",
          "<cmd>FzfLua lsp_workspace_symbols<CR>",
          vim.tbl_extend("force", opts, { desc = "Workspace symbols" })
        )

        keymap.set("n", "[d", function()
          vim.diagnostic.jump({ count = -1 })
        end, vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
        keymap.set("n", "]d", function()
          vim.diagnostic.jump({ count = 1 })
        end, vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))

        keymap.set("n", "<leader>lR", "<cmd>lsp restart<CR>", vim.tbl_extend("force", opts, { desc = "Restart LSP" }))
        keymap.set("n", "<leader>ll", function()
          vim.cmd("edit " .. vim.fn.fnameescape(vim.lsp.get_log_path()))
        end, vim.tbl_extend("force", opts, { desc = "Open LSP log" }))
        keymap.set("n", "<leader>li", "<cmd>checkhealth lsp<CR>", vim.tbl_extend("force", opts, { desc = "LSP info" }))

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.name == "gopls" then
          client.server_capabilities.semanticTokensProvider = nil
        end
        if client and client:supports_method("textDocument/codeLens", ev.buf) then
          keymap.set(
            "n",
            "<leader>lc",
            vim.lsp.codelens.run,
            vim.tbl_extend("force", opts, { desc = "Run codelens on current line" })
          )
          keymap.set(
            "n",
            "<leader>lC",
            vim.lsp.codelens.refresh,
            vim.tbl_extend("force", opts, { desc = "Refresh codelens" })
          )
          keymap.set("n", "<leader>lL", function()
            vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
          end, vim.tbl_extend("force", opts, { desc = "Toggle codelens" }))
        end

        vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
        keymap.set("n", "<leader>lh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
        end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))

        keymap.set("n", "<leader>ld", function()
          if #vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 }) == 0 then
            return
          end
          local source_win = vim.api.nvim_get_current_win()
          local _, float_win = vim.diagnostic.open_float({ scope = "line" })
          place_float_top_right(float_win, source_win)
        end, vim.tbl_extend("force", opts, { desc = "Show line diagnostic" }))
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
          codelenses = {
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = false,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          analyses = {
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            any = true,
          },
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
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          checkOnSave = true,
          check = {
            command = "clippy",
          },
          procMacro = {
            enable = true,
          },
          inlayHints = {
            chainingHints = { enable = true },
            closingBraceHints = { enable = true, minLines = 10 },
            parameterHints = { enable = true },
            typeHints = { enable = true },
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
