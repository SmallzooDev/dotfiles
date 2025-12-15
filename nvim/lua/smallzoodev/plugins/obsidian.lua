return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("obsidian").setup({
      ui = {
        enable = false,
        checkboxes = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "󰱒", hl_group = "ObsidianDone" },
          ["!"] = { char = "󰀪", hl_group = "ObsidianImportant" },
          [">"] = { char = "󰁔", hl_group = "ObsidianRightArrow" },
        },
      },
      mappings = {
        ["<CR>"] = {
          action = function()
            return require("obsidian.util").smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      workspaces = {
        {
          name = "public",
          path = "~/public_vault",
          overrides = {
            templates = {
              folder = "templates",
            },
          },
        },
        {
          name = "private",
          path = "~/private_vault",
          overrides = {
            templates = {
              folder = "templates",
            },
          },
        },
      },
      note_id_func = function(title)
        local suffix = os.date("%y%m%d")
        local base_name

        if title ~= nil then
          local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
          base_name = clean_title .. "_" .. suffix
        else
          base_name = suffix
        end

        local client = require("obsidian").get_client()
        local vault_path = client.dir.filename
        local counter = 0
        local final_name = base_name

        while vim.fn.filereadable(vault_path .. "/" .. final_name .. ".md") == 1 do
          final_name = string.format("%s_%02d", base_name, counter)
          counter = counter + 1
          if counter > 99 then
            break
          end
        end

        return final_name
      end,
      templates = {
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        default_tags = { "daily-notes" },
        template = "daily.md",
      },
      follow_url_func = function(url)
        vim.fn.jobstart({ "open", url })
      end,
    })

    local function generate_note_filename(title)
      local suffix = os.date("%y%m%d")
      local base_name

      if title ~= nil and title ~= "" then
        local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
        base_name = clean_title .. "_" .. suffix
      else
        base_name = suffix
      end

      local client = require("obsidian").get_client()
      local vault_path = client.dir.filename
      local counter = 0
      local final_name = base_name

      while vim.fn.filereadable(vault_path .. "/" .. final_name .. ".md") == 1 do
        final_name = string.format("%s_%02d", base_name, counter)
        counter = counter + 1
        if counter > 99 then
          break
        end
      end

      return final_name
    end

    vim.api.nvim_create_user_command("ObsidianRenameAndReload", function(opts)
      local new_title = opts.args
      if new_title == "" then
        new_title = vim.fn.input("Enter new title: ")
      end

      if new_title ~= "" then
        local new_filename = generate_note_filename(new_title)
        vim.cmd("ObsidianRename " .. new_filename)

        vim.defer_fn(function()
          vim.cmd("checktime")
          vim.cmd("bufdo e")
        end, 500)
      end
    end, { nargs = "?" })

    vim.api.nvim_create_user_command("ObsidianNewProject", function(opts)
      local title = opts.args
      if title == "" then
        title = vim.fn.input("Project name: ")
      end
      if title ~= "" then
        local client = require("obsidian").get_client()
        local vault_path = client.dir.filename
        local date_prefix = os.date("%Y%m%d")
        local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
        local dir_name = date_prefix .. "-" .. clean_title
        local project_dir = vault_path .. "/01-Projects/" .. dir_name
        local index_path = project_dir .. "/index.md"

        vim.fn.mkdir(project_dir, "p")

        vim.cmd("edit " .. index_path)
        vim.defer_fn(function()
          vim.cmd("ObsidianTemplate project")
        end, 100)
      end
    end, { nargs = "?" })

    vim.api.nvim_create_user_command("ObsidianNewArea", function(opts)
      local title = opts.args
      if title == "" then
        title = vim.fn.input("Area name: ")
      end
      if title ~= "" then
        local client = require("obsidian").get_client()
        local vault_path = client.dir.filename
        local date_prefix = os.date("%Y%m%d")
        local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
        local dir_name = date_prefix .. "-" .. clean_title
        local area_dir = vault_path .. "/02-Areas/" .. dir_name
        local index_path = area_dir .. "/index.md"

        vim.fn.mkdir(area_dir, "p")
        vim.cmd("edit " .. index_path)
        vim.defer_fn(function()
          vim.cmd("ObsidianTemplate area")
        end, 100)
      end
    end, { nargs = "?" })

    vim.api.nvim_create_user_command("ObsidianNewResource", function(opts)
      local title = opts.args
      if title == "" then
        title = vim.fn.input("Resource name: ")
      end
      if title ~= "" then
        local client = require("obsidian").get_client()
        local vault_path = client.dir.filename
        local date_prefix = os.date("%Y%m%d")
        local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
        local dir_name = date_prefix .. "-" .. clean_title
        local resource_dir = vault_path .. "/03-Resources/" .. dir_name
        local index_path = resource_dir .. "/index.md"

        vim.fn.mkdir(resource_dir, "p")
        vim.cmd("edit " .. index_path)
        vim.defer_fn(function()
          vim.cmd("ObsidianTemplate resource")
        end, 100)
      end
    end, { nargs = "?" })

    vim.api.nvim_create_user_command("ObsidianNewSequenced", function(opts)
      local title = opts.args
      if title == "" then
        title = vim.fn.input("Note name: ")
      end
      if title ~= "" then
        local current_dir
        local current_file = vim.fn.expand("%:p")
        if current_file ~= "" then
          current_dir = vim.fn.fnamemodify(current_file, ":h")
        else
          current_dir = vim.fn.getcwd()
        end

        local files = vim.fn.glob(current_dir .. "/*", false, true)
        local file_count = 0
        for _, file in ipairs(files) do
          if vim.fn.isdirectory(file) == 0 then
            file_count = file_count + 1
          end
        end

        local sequence = string.format("%04d", file_count)

        local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")

        local final_name = sequence .. "-" .. clean_title .. ".md"
        local full_path = current_dir .. "/" .. final_name

        vim.cmd("edit " .. vim.fn.fnameescape(full_path))
        vim.cmd("write")
      end
    end, { nargs = "?" })
  end,
  keys = {
    { "<leader>b", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch", ft = "markdown" },
    { "<leader>/", "<cmd>ObsidianSearch<CR>", desc = "Search notes", ft = "markdown" },
    { "<leader>on", "<cmd>ObsidianNewSequenced<CR>", desc = "New note", ft = "markdown" },
    { "<leader>or", "<cmd>ObsidianRenameAndReload<CR>", desc = "Rename note", ft = "markdown" },
    { "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "List links", ft = "markdown" },
    { "<leader>ot", "<cmd>ObsidianTags<CR>", desc = "Search tags", ft = "markdown" },
    { "<leader>op", "<cmd>ObsidianNewProject<CR>", desc = "New project", ft = "markdown" },
    { "<leader>oa", "<cmd>ObsidianNewArea<CR>", desc = "New area", ft = "markdown" },
    { "<leader>oz", "<cmd>ObsidianNewResource<CR>", desc = "New resource", ft = "markdown" },
    { "<leader>td", "<cmd>ObsidianToday<CR>", desc = "Today's note", ft = "markdown" },
    { "<leader>ys", "<cmd>ObsidianYesterday<CR>", desc = "Yesterday's note", ft = "markdown" },
    { "<leader>od", "<cmd>ObsidianDailies<CR>", desc = "Browse dailies", ft = "markdown" },
    { "<leader>oat", "<cmd>ObsidianTemplate<CR>", desc = "Add template", ft = "markdown" },
    { "<leader>owc", "<cmd>ObsidianWorkspace<CR>", desc = "Change workspace", ft = "markdown" },
    { "<leader>oe", ":ObsidianExtractNote<CR>", desc = "Extract to new note", mode = "v", ft = "markdown" },
    { "<leader>olx", ":ObsidianLink<CR>", desc = "Link to existing", mode = "v", ft = "markdown" },
    { "<leader>oln", ":ObsidianLinkNew<CR>", desc = "Link to new note", mode = "v", ft = "markdown" },
  },
}
