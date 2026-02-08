return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
  },
  config = function()
    local keymap = vim.keymap

    vim.diagnostic.config({
      underline = false,
      virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰬅",
          [vim.diagnostic.severity.WARN] = "󱈸",
          [vim.diagnostic.severity.HINT] = "󰫵",
          [vim.diagnostic.severity.INFO] = "󰫶",
        },
      },
      severity_sort = true,
      float = { border = "rounded", source = true },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        keymap.set(
          "n",
          "gR",
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
        keymap.set(
          "n",
          "gt",
          "<cmd>FzfLua lsp_typedefs<CR>",
          vim.tbl_extend("force", opts, { desc = "Show LSP type definitions" })
        )
        keymap.set(
          "n",
          "gu",
          "<cmd>FzfLua lsp_references<CR>",
          vim.tbl_extend("force", opts, { desc = "Show LSP references (usages)" })
        )
        keymap.set("n", "gI", function()
          vim.lsp.buf.typehierarchy("supertypes")
        end, vim.tbl_extend("force", opts, { desc = "Go to super/parent type" }))

        -- Helix-style Space prefix: LSP actions
        keymap.set(
          { "n", "v" },
          "<leader>a",
          "<cmd>FzfLua lsp_code_actions<CR>",
          vim.tbl_extend("force", opts, { desc = "Code actions" })
        )
        keymap.set("n", "<leader>r", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
        keymap.set("n", "<leader>k", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))

        -- Helix-style Space prefix: LSP pickers
        keymap.set(
          "n",
          "<leader>s",
          "<cmd>FzfLua lsp_document_symbols<CR>",
          vim.tbl_extend("force", opts, { desc = "Document symbols" })
        )
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

        keymap.set("n", "<leader>lr", ":LspRestart<CR>", vim.tbl_extend("force", opts, { desc = "Restart LSP" }))
        keymap.set("n", "<leader>ll", function()
          vim.cmd("edit " .. vim.lsp.get_log_path())
        end, vim.tbl_extend("force", opts, { desc = "Open LSP log" }))
        keymap.set("n", "<leader>li", "<cmd>checkhealth lsp<CR>", vim.tbl_extend("force", opts, { desc = "LSP info" }))

        vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
        keymap.set("n", "<leader>lh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
        end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))

        keymap.set("n", "<leader>ld", function()
          local config = vim.diagnostic.config()
          vim.diagnostic.config({ virtual_text = not config.virtual_text and { spacing = 2 } or false })
        end, vim.tbl_extend("force", opts, { desc = "Toggle diagnostics virtual text" }))

        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = ev.buf,
          callback = function()
            vim.diagnostic.open_float({ focusable = false, scope = "cursor" })
          end,
        })
      end,
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
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
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
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
          checkOnSave = {
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

    vim.lsp.config("marksman", {
      root_dir = function(fname)
        local util = require("lspconfig.util")
        if fname:match("vimwiki/") then
          return nil
        end
        return util.root_pattern(".git", ".marksman.toml")(fname)
      end,
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

    vim.lsp.enable({ "lua_ls", "gopls", "pyright", "marksman", "rust_analyzer", "clangd" })
  end,
}
