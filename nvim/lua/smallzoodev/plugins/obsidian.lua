return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "work",
        path = "~/kane_wiki",
        overrides = {
          templates = {
            folder = "templates",
          },
        },
      },
      {
        name = "private",
        path = "~/smallzoo",
        overrides = {
          templates = {
            folder = "templates",
          },
        },
      },
    },
    -- Use title as filename with date suffix
    note_id_func = function(title)
      local suffix = os.date("%y%m%d")
      -- If title is provided, use it as the filename with date
      if title ~= nil then
        -- Convert title to lowercase and replace spaces with hyphens
        local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        return clean_title .. "_" .. suffix
      else
        -- If no title, use just the date
        return suffix
      end
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
  },
  keys = {
    { "<BS>", "<cmd>ObsidianBacklinks<CR>", desc = "Show backlinks", ft = "markdown" },
    { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New note", ft = "markdown" },
    { "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "New note", ft = "markdown" },
    { "<leader>ot", "<cmd>ObsidianTags<CR>", desc = "Search tags", ft = "markdown" },
    { "<leader>b", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch", ft = "markdown" },
    { "<leader>/", "<cmd>ObsidianSearch<CR>", desc = "Search notes", ft = "markdown" },
    { "<leader>td", "<cmd>ObsidianToday<CR>", desc = "Today's note", ft = "markdown" },
    { "<leader>ys", "<cmd>ObsidianYesterday<CR>", desc = "Yesterday's note", ft = "markdown" },
    { "<leader>owc", "<cmd>ObsidianWorkspace<CR>", desc = "Change workspace", ft = "markdown" },
  },
}
