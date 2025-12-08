return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    local function select_tab_or_switch(prompt_bufnr)
      local entry = action_state.get_selected_entry()
      if not entry then
        return
      end
      local filepath = entry.path or entry.filename
      if not filepath then
        actions.select_default(prompt_bufnr)
        return
      end
      filepath = vim.fn.fnamemodify(filepath, ":p")
      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
          local buf = vim.api.nvim_win_get_buf(win)
          local bufpath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p")
          if bufpath == filepath then
            actions.close(prompt_bufnr)
            vim.api.nvim_set_current_tabpage(tab)
            vim.api.nvim_set_current_win(win)
            return
          end
        end
      end
      actions.select_tab(prompt_bufnr)
    end

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-x>"] = trouble_telescope.open,
            ["<CR>"] = actions.select_default,
            ["<S-CR>"] = select_tab_or_switch,
            ["<C-v>"] = actions.select_vertical,
            ["<C-s>"] = actions.select_horizontal,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    local keymap = vim.keymap

    keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<cr>", { desc = "Grep in cwd" })
    keymap.set("n", "<leader>?", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
    keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
  end,
}
