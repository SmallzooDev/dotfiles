return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local function select_tab_or_switch()
      local oil = require("oil")
      local entry = oil.get_cursor_entry()
      if not entry then
        return
      end
      if entry.type == "directory" then
        oil.select()
        return
      end
      local dir = oil.get_current_dir()
      local filepath = vim.fn.fnamemodify(dir .. entry.name, ":p")
      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
          local buf = vim.api.nvim_win_get_buf(win)
          local bufpath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p")
          if bufpath == filepath then
            oil.close()
            vim.api.nvim_set_current_tabpage(tab)
            vim.api.nvim_set_current_win(win)
            return
          end
        end
      end
      oil.close()
      vim.cmd("tabnew " .. vim.fn.fnameescape(filepath))
    end

    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
      },
      float = {
        padding = 2,
        max_width = 90,
        max_height = 0,
        border = "rounded",
      },
      win_options = {
        winbar = "%{v:lua.require('oil').get_current_dir()}",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = select_tab_or_switch,
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["q"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
      },
    })

    vim.keymap.set("n", "<leader>e", function()
      require("oil").open_float()
    end, { desc = "Open file explorer" })
  end,
}
