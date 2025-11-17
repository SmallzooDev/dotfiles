return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local keymap = vim.keymap -- for conciseness
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        -- Sync with ideavimrc: gu for usages (like IdeaVim's ShowUsages)
        opts.desc = "Show LSP references (usages)"
        keymap.set("n", "gu", "<cmd>Telescope lsp_references<CR>", opts) -- show usages (same as gR)

        -- Sync with ideavimrc: gI for go to super/parent (like IdeaVim's GotoSuperMethod)
        opts.desc = "Go to super/parent type"
        keymap.set("n", "gI", function()
          vim.lsp.buf.typehierarchy("supertypes")
        end, opts)

        -- Open in new tab variants (leader + t + g + <key>)
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

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
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
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
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
        },
      },
    })

    -- rust_analyzer managed by rustaceanvim

    -- Exclude vimwiki directory from markdown LSP if marksman is added
    vim.lsp.config("marksman", {
      root_dir = function(fname)
        local util = require("lspconfig.util")
        -- Don't attach to files in vimwiki directory
        if fname:match("vimwiki/") then
          return nil
        end
        return util.root_pattern(".git", ".marksman.toml")(fname)
      end,
    })
  end,
}
