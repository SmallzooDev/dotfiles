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
      virtual_text = {
        spacing = 2,
        format = function(d)
          local msg = d.message:gsub("\n", " ")
          if #msg > 50 then
            return msg:sub(1, 47) .. "..."
          end
          return msg
        end,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "󰠠",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
      severity_sort = true,
      float = { border = "rounded", source = true },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        local function map_with_split(key, action, desc, is_func)
          local splits = {
            { prefix = "", cmd = nil, suffix = "" },
            { prefix = "<leader>v", cmd = "vsplit", suffix = " in vsplit" },
            { prefix = "<leader>s", cmd = "split", suffix = " in split" },
          }
          for _, split in ipairs(splits) do
            opts.desc = desc .. split.suffix
            if split.cmd then
              keymap.set("n", split.prefix .. key, function()
                vim.cmd(split.cmd)
                if is_func then
                  action()
                else
                  vim.cmd(action)
                end
              end, opts)
            else
              if is_func then
                keymap.set("n", key, action, opts)
              else
                keymap.set("n", key, "<cmd>" .. action .. "<CR>", opts)
              end
            end
          end
        end

        map_with_split("gR", "Telescope lsp_references", "Show LSP references")
        map_with_split("gD", vim.lsp.buf.declaration, "Go to declaration", true)
        map_with_split("gd", "Telescope lsp_definitions", "Show LSP definitions")
        map_with_split("gi", "Telescope lsp_implementations", "Show LSP implementations")
        map_with_split("gt", "Telescope lsp_type_definitions", "Show LSP type definitions")
        map_with_split("gu", "Telescope lsp_references", "Show LSP references (usages)")
        map_with_split("gI", function()
          vim.lsp.buf.typehierarchy("supertypes")
        end, "Go to super/parent type", true)

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
          vim.diagnostic.config({ virtual_text = not config.virtual_text and { spacing = 2 } or false })
        end, opts)
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
