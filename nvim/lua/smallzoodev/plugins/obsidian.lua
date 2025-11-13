return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("obsidian").setup({
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
    -- Use title as filename with date suffix and counter for duplicates
    note_id_func = function(title)
      local suffix = os.date("%y%m%d")
      local base_name

      if title ~= nil then
        -- Replace spaces with hyphens, preserve camelCase
        local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
        base_name = clean_title .. "_" .. suffix
      else
        -- If no title, use just the date
        base_name = suffix
      end

      -- Check if file exists and add counter if needed
      local client = require("obsidian").get_client()
      local vault_path = client.dir.filename
      local counter = 0
      local final_name = base_name

      while vim.fn.filereadable(vault_path .. "/" .. final_name .. ".md") == 1 do
        final_name = string.format("%s_%02d", base_name, counter)
        counter = counter + 1
        if counter > 99 then break end -- safety limit
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
      -- Custom function to open URLs in browser
      follow_url_func = function(url)
        vim.fn.jobstart({ "open", url })
      end,
    })

    -- Helper function to generate filename following note_id_func rules
    local function generate_note_filename(title)
      local suffix = os.date("%y%m%d")
      local base_name

      if title ~= nil and title ~= "" then
        local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
        base_name = clean_title .. "_" .. suffix
      else
        base_name = suffix
      end

      -- Check if file exists and add counter if needed
      local client = require("obsidian").get_client()
      local vault_path = client.dir.filename
      local counter = 0
      local final_name = base_name

      while vim.fn.filereadable(vault_path .. "/" .. final_name .. ".md") == 1 do
        final_name = string.format("%s_%02d", base_name, counter)
        counter = counter + 1
        if counter > 99 then break end
      end

      return final_name
    end

    -- Custom rename command with auto-reload and note_id_func rules
    vim.api.nvim_create_user_command("ObsidianRenameAndReload", function(opts)
      local new_title = opts.args
      if new_title == "" then
        new_title = vim.fn.input("Enter new title: ")
      end

      if new_title ~= "" then
        local new_filename = generate_note_filename(new_title)
        vim.cmd("ObsidianRename " .. new_filename)

        -- Wait a bit for rename to complete, then reload all buffers
        vim.defer_fn(function()
          vim.cmd("checktime")
          vim.cmd("bufdo e")
        end, 500)
      end
    end, { nargs = "?" })

    -- PARA helper: Create new project with directory structure
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

        -- Create directory
        vim.fn.mkdir(project_dir, "p")

        -- Create index.md with template
        vim.cmd("edit " .. index_path)
        vim.defer_fn(function()
          vim.cmd("ObsidianTemplate project")
        end, 100)
      end
    end, { nargs = "?" })

    -- PARA helper: Create new area with directory structure
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

    -- PARA helper: Create new resource with directory structure
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

    -- Custom new note with sequence number
    vim.api.nvim_create_user_command("ObsidianNewSequenced", function(opts)
      local title = opts.args
      if title == "" then
        title = vim.fn.input("Note name: ")
      end
      if title ~= "" then
        -- Get directory of current file, or fall back to cwd
        local current_dir
        local current_file = vim.fn.expand("%:p")
        if current_file ~= "" then
          current_dir = vim.fn.fnamemodify(current_file, ":h")
        else
          current_dir = vim.fn.getcwd()
        end

        -- Count existing files (not directories) in current directory
        local files = vim.fn.glob(current_dir .. "/*", false, true)
        local file_count = 0
        for _, file in ipairs(files) do
          if vim.fn.isdirectory(file) == 0 then
            file_count = file_count + 1
          end
        end

        -- Generate 4-digit sequence number
        local sequence = string.format("%04d", file_count)

        -- Clean title (preserve camelCase, replace spaces with hyphens)
        local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")

        -- Create final filename
        local final_name = sequence .. "-" .. clean_title .. ".md"
        local full_path = current_dir .. "/" .. final_name

        -- Create, open, and save the file
        vim.cmd("edit " .. vim.fn.fnameescape(full_path))
        vim.cmd("write")
      end
    end, { nargs = "?" })

  end,
  keys = {
    -- Navigation
    { "<BS>", "<cmd>ObsidianBacklinks<CR>", desc = "Show backlinks", ft = "markdown" },
    { "]o", desc = "Next link", ft = "markdown" },
    { "[o", desc = "Prev link", ft = "markdown" },
    { "<leader>b", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch", ft = "markdown" },
    { "<leader>/", "<cmd>ObsidianSearch<CR>", desc = "Search notes", ft = "markdown" },

    -- Note management
    { "<leader>on", "<cmd>ObsidianNewSequenced<CR>", desc = "New note", ft = "markdown" },
    { "<leader>or", "<cmd>ObsidianRenameAndReload<CR>", desc = "Rename note", ft = "markdown" },
    { "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "List links", ft = "markdown" },
    { "<leader>ot", "<cmd>ObsidianTags<CR>", desc = "Search tags", ft = "markdown" },

    -- PARA commands
    { "<leader>op", "<cmd>ObsidianNewProject<CR>", desc = "New project", ft = "markdown" },
    { "<leader>oa", "<cmd>ObsidianNewArea<CR>", desc = "New area", ft = "markdown" },
    { "<leader>oz", "<cmd>ObsidianNewResource<CR>", desc = "New resource", ft = "markdown" },

    -- Daily notes
    { "<leader>td", "<cmd>ObsidianToday<CR>", desc = "Today's note", ft = "markdown" },
    { "<leader>ys", "<cmd>ObsidianYesterday<CR>", desc = "Yesterday's note", ft = "markdown" },
    { "<leader>od", "<cmd>ObsidianDailies<CR>", desc = "Browse dailies", ft = "markdown" },

    -- Templates & workspace
    { "<leader>oat", "<cmd>ObsidianTemplate<CR>", desc = "Add template", ft = "markdown" },
    { "<leader>owc", "<cmd>ObsidianWorkspace<CR>", desc = "Change workspace", ft = "markdown" },

    -- Visual mode: Extract and link
    { "<leader>oe", ":ObsidianExtractNote<CR>", desc = "Extract to new note", mode = "v", ft = "markdown" },
    { "<leader>olx", ":ObsidianLink<CR>", desc = "Link to existing", mode = "v", ft = "markdown" },
    { "<leader>oln", ":ObsidianLinkNew<CR>", desc = "Link to new note", mode = "v", ft = "markdown" },
  },
}
