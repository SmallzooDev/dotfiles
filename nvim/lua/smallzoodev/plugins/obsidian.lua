return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- Shared function for generating unique note filenames
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

    require("obsidian").setup({
      ui = {
        enable = false,
        checkboxes = {
          [" "] = { order = 1, char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { order = 2, char = "", hl_group = "ObsidianDone" },
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
      note_id_func = generate_note_filename,
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

    -- Factory for creating PARA folder commands
    local function create_para_command(cmd_name, folder, template, prompt_text)
      vim.api.nvim_create_user_command(cmd_name, function(opts)
        local title = opts.args
        if title == "" then
          title = vim.fn.input(prompt_text)
        end
        if title ~= "" then
          local client = require("obsidian").get_client()
          local vault_path = client.dir.filename
          local date_prefix = os.date("%Y%m%d")
          local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
          local dir_name = date_prefix .. "-" .. clean_title
          local target_dir = vault_path .. "/" .. folder .. "/" .. dir_name
          local index_path = target_dir .. "/index.md"

          vim.fn.mkdir(target_dir, "p")
          vim.cmd("edit " .. index_path)
          vim.defer_fn(function()
            vim.cmd("ObsidianTemplate " .. template)
          end, 100)
        end
      end, { nargs = "?" })
    end

    create_para_command("ObsidianNewProject", "01-Projects", "project", "Project name: ")
    create_para_command("ObsidianNewArea", "02-Areas", "area", "Area name: ")
    create_para_command("ObsidianNewResource", "03-Resources", "resource", "Resource name: ")
  end,
  keys = {
    { "<leader>Ol", "<cmd>ObsidianLinks<CR>", desc = "List links", ft = "markdown" },
    { "<leader>Ot", "<cmd>ObsidianTags<CR>", desc = "Search tags", ft = "markdown" },
    { "<leader>Op", "<cmd>ObsidianNewProject<CR>", desc = "New project", ft = "markdown" },
    { "<leader>Oa", "<cmd>ObsidianNewArea<CR>", desc = "New area", ft = "markdown" },
    { "<leader>Oz", "<cmd>ObsidianNewResource<CR>", desc = "New resource", ft = "markdown" },
    { "<leader>td", "<cmd>ObsidianToday<CR>", desc = "Today's note", ft = "markdown" },
    { "<leader>Olx", ":ObsidianLink<CR>", desc = "Link to existing", mode = "v", ft = "markdown" },
    { "<leader>Oln", ":ObsidianLinkNew<CR>", desc = "Link to new note", mode = "v", ft = "markdown" },
  },
}
