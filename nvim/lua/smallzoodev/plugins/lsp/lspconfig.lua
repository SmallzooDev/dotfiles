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
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "Show LSP references (usages)"
        keymap.set("n", "gu", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to super/parent type"
        keymap.set("n", "gI", function()
          vim.lsp.buf.typehierarchy("supertypes")
        end, opts)

        opts.desc = "Show LSP references in new tab"
        keymap.set("n", "<leader>tgR", function()
          vim.cmd("tab split")
          vim.cmd("Telescope lsp_references")
        end, opts)

        opts.desc = "Go to declaration in new tab"
        keymap.set("n", "<leader>tgD", function()
          vim.cmd("tab split")
          vim.lsp.buf.declaration()
        end, opts)

        opts.desc = "Show LSP definitions in new tab"
        keymap.set("n", "<leader>tgd", function()
          vim.cmd("tab split")
          vim.cmd("Telescope lsp_definitions")
        end, opts)

        opts.desc = "Show LSP implementations in new tab"
        keymap.set("n", "<leader>tgi", function()
          vim.cmd("tab split")
          vim.cmd("Telescope lsp_implementations")
        end, opts)

        opts.desc = "Show LSP type definitions in new tab"
        keymap.set("n", "<leader>tgt", function()
          vim.cmd("tab split")
          vim.cmd("Telescope lsp_type_definitions")
        end, opts)

        opts.desc = "Show LSP references (usages) in new tab"
        keymap.set("n", "<leader>tgu", function()
          vim.cmd("tab split")
          vim.cmd("Telescope lsp_references")
        end, opts)

        opts.desc = "Go to super/parent type in new tab"
        keymap.set("n", "<leader>tgI", function()
          vim.cmd("tab split")
          vim.lsp.buf.typehierarchy("supertypes")
        end, opts)

        -- Vertical split variants
        opts.desc = "Show LSP references in vsplit"
        keymap.set("n", "<leader>vgR", function()
          vim.cmd("vsplit")
          vim.cmd("Telescope lsp_references")
        end, opts)

        opts.desc = "Go to declaration in vsplit"
        keymap.set("n", "<leader>vgD", function()
          vim.cmd("vsplit")
          vim.lsp.buf.declaration()
        end, opts)

        opts.desc = "Show LSP definitions in vsplit"
        keymap.set("n", "<leader>vgd", function()
          vim.cmd("vsplit")
          vim.cmd("Telescope lsp_definitions")
        end, opts)

        opts.desc = "Show LSP implementations in vsplit"
        keymap.set("n", "<leader>vgi", function()
          vim.cmd("vsplit")
          vim.cmd("Telescope lsp_implementations")
        end, opts)

        opts.desc = "Show LSP type definitions in vsplit"
        keymap.set("n", "<leader>vgt", function()
          vim.cmd("vsplit")
          vim.cmd("Telescope lsp_type_definitions")
        end, opts)

        opts.desc = "Show LSP references (usages) in vsplit"
        keymap.set("n", "<leader>vgu", function()
          vim.cmd("vsplit")
          vim.cmd("Telescope lsp_references")
        end, opts)

        opts.desc = "Go to super/parent type in vsplit"
        keymap.set("n", "<leader>vgI", function()
          vim.cmd("vsplit")
          vim.lsp.buf.typehierarchy("supertypes")
        end, opts)

        -- Horizontal split variants
        opts.desc = "Show LSP references in split"
        keymap.set("n", "<leader>sgR", function()
          vim.cmd("split")
          vim.cmd("Telescope lsp_references")
        end, opts)

        opts.desc = "Go to declaration in split"
        keymap.set("n", "<leader>sgD", function()
          vim.cmd("split")
          vim.lsp.buf.declaration()
        end, opts)

        opts.desc = "Show LSP definitions in split"
        keymap.set("n", "<leader>sgd", function()
          vim.cmd("split")
          vim.cmd("Telescope lsp_definitions")
        end, opts)

        opts.desc = "Show LSP implementations in split"
        keymap.set("n", "<leader>sgi", function()
          vim.cmd("split")
          vim.cmd("Telescope lsp_implementations")
        end, opts)

        opts.desc = "Show LSP type definitions in split"
        keymap.set("n", "<leader>sgt", function()
          vim.cmd("split")
          vim.cmd("Telescope lsp_type_definitions")
        end, opts)

        opts.desc = "Show LSP references (usages) in split"
        keymap.set("n", "<leader>sgu", function()
          vim.cmd("split")
          vim.cmd("Telescope lsp_references")
        end, opts)

        opts.desc = "Go to super/parent type in split"
        keymap.set("n", "<leader>sgI", function()
          vim.cmd("split")
          vim.lsp.buf.typehierarchy("supertypes")
        end, opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

        vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
        opts.desc = "Toggle inlay hints"
        keymap.set("n", "<leader>lh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
        end, opts)

        opts.desc = "Toggle diagnostics virtual text"
        keymap.set("n", "<leader>ld", function()
          local config = vim.diagnostic.config()
          vim.diagnostic.config({ virtual_text = not config.virtual_text })
        end, opts)
      end,
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.diagnostic.config({
      virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.config("eslint", {
      filetypes = { "javascript", "typescript" },
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

    vim.lsp.enable({ "lua_ls", "gopls", "pyright", "eslint", "ts_ls", "marksman", "rust_analyzer" })
  end,
}
