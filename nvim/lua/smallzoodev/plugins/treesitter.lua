local ensure_installed = {
  "json",
  "yaml",
  "markdown",
  "markdown_inline",
  "bash",
  "lua",
  "vim",
  "dockerfile",
  "gitignore",
  "query",
  "vimdoc",
  "c",
  "cpp",
  "cmake",
  "python",
  "go",
  "gomod",
  "gowork",
  "gosum",
  "rust",
  "toml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = function()
      require("nvim-treesitter").install(ensure_installed)
    end,
    config = function()
      require("nvim-treesitter").setup()

      -- Enable treesitter highlighting & indentation
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      vim.treesitter.language.register("bash", "zsh")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select_mod = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local swap = require("nvim-treesitter-textobjects.swap")
      local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

      -- Select textobjects
      local select_keymaps = {
        ["a="] = "@assignment.outer",
        ["i="] = "@assignment.inner",
        ["l="] = "@assignment.lhs",
        ["r="] = "@assignment.rhs",
        ["a:"] = "@property.outer",
        ["i:"] = "@property.inner",
        ["l:"] = "@property.lhs",
        ["r:"] = "@property.rhs",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["af"] = "@call.outer",
        ["if"] = "@call.inner",
        ["am"] = "@function.outer",
        ["im"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      }
      for key, query in pairs(select_keymaps) do
        vim.keymap.set({ "x", "o" }, key, function()
          select_mod.select_textobject(query)
        end)
      end

      -- Incremental selection
      vim.keymap.set("n", "<CR>", function()
        select_mod.select_textobject("@function.inner")
      end, { desc = "Init treesitter selection" })
      vim.keymap.set("x", "<CR>", function()
        select_mod.select_textobject("@function.outer")
      end, { desc = "Expand treesitter selection" })
      vim.keymap.set("x", "<BS>", "<Esc>", { desc = "Shrink treesitter selection" })

      -- Swap
      local swap_next = {
        ["<leader>na"] = "@parameter.inner",
        ["<leader>n:"] = "@property.outer",
        ["<leader>nm"] = "@function.outer",
      }
      local swap_prev = {
        ["<leader>pa"] = "@parameter.inner",
        ["<leader>p:"] = "@property.outer",
        ["<leader>pm"] = "@function.outer",
      }
      for key, query in pairs(swap_next) do
        vim.keymap.set("n", key, function()
          swap.swap_textobject(query)
        end)
      end
      for key, query in pairs(swap_prev) do
        vim.keymap.set("n", key, function()
          swap.swap_textobject(query, "previous")
        end)
      end

      -- Move
      local goto_next_start = {
        ["]f"] = "@call.outer",
        ["]m"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]i"] = "@conditional.outer",
        ["]l"] = "@loop.outer",
      }
      local goto_next_end = {
        ["]F"] = "@call.outer",
        ["]M"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]I"] = "@conditional.outer",
        ["]L"] = "@loop.outer",
      }
      local goto_prev_start = {
        ["[f"] = "@call.outer",
        ["[m"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[i"] = "@conditional.outer",
        ["[l"] = "@loop.outer",
      }
      local goto_prev_end = {
        ["[F"] = "@call.outer",
        ["[M"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[I"] = "@conditional.outer",
        ["[L"] = "@loop.outer",
      }
      for key, query in pairs(goto_next_start) do
        vim.keymap.set({ "n", "x", "o" }, key, function()
          move.goto_next_start(query)
        end)
      end
      for key, query in pairs(goto_next_end) do
        vim.keymap.set({ "n", "x", "o" }, key, function()
          move.goto_next_end(query)
        end)
      end
      for key, query in pairs(goto_prev_start) do
        vim.keymap.set({ "n", "x", "o" }, key, function()
          move.goto_previous_start(query)
        end)
      end
      for key, query in pairs(goto_prev_end) do
        vim.keymap.set({ "n", "x", "o" }, key, function()
          move.goto_previous_end(query)
        end)
      end
      -- Scope/fold (with query_group)
      vim.keymap.set({ "n", "x", "o" }, "]s", function()
        move.goto_next_start("@scope", "locals")
      end)
      vim.keymap.set({ "n", "x", "o" }, "]z", function()
        move.goto_next_start("@fold", "folds")
      end)

      -- Repeatable move (;/, for last textobject move, f/F/t/T)
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
  },
}
