return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
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
      },
      win_options = {
        winbar = "%{v:lua.require('oil').get_current_dir()}",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
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

    vim.keymap.set("n", "<leader>ee", "<cmd>Oil<cr>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>ef", function()
      require("oil").open_float()
    end, { desc = "Open parent directory in float" })
    vim.keymap.set("n", "<leader>eo", function()
      local path = vim.fn.input("Oil path: ", "", "dir")
      if path ~= "" then
        require("oil").open(path)
      end
    end, { desc = "Open Oil at specific path" })
  end,
}
