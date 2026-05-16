return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.ai").setup({
      n_lines = 500,
    })

    require("mini.surround").setup({
      mappings = {
        add = "sa",
        delete = "sd",
        find = "",
        find_left = "",
        highlight = "sh",
        replace = "sr",
        update_n_lines = "sn",
      },
    })

    require("mini.pairs").setup({
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    })

    require("mini.comment").setup()

    require("mini.indentscope").setup({
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        delay = 0,
        animation = require("mini.indentscope").gen_animation.none(),
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "Trouble",
        "copilot-chat",
        "help",
        "lazy",
        "mason",
        "notify",
        "snacks_terminal",
        "minifiles",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })

    require("mini.move").setup({
      mappings = {
        left = "<S-h>",
        right = "<S-l>",
        down = "J",
        up = "K",
        line_left = "<S-h>",
        line_right = "<S-l>",
        line_down = "J",
        line_up = "K",
      },
    })

    require("mini.hipatterns").setup({
      highlighters = {
        hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
      },
    })

    require("mini.icons").setup()
    require("mini.icons").mock_nvim_web_devicons()

    require("mini.files").setup({
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 60,
        max_number = 3,
      },
    })

    vim.keymap.set("n", "<leader>e", function()
      local path = vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil
      local ok = pcall(require("mini.files").open, path)
      if not ok then
        require("mini.files").open()
      end
    end, { desc = "Open mini.files (current file)" })

    vim.keymap.set("n", "<leader>E", function()
      require("mini.files").open(vim.uv.cwd(), true)
    end, { desc = "Open mini.files (cwd)" })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        vim.keymap.set("n", "<CR>", function()
          require("mini.files").go_in({ close_on_file = true })
        end, { buffer = buf_id, desc = "Enter dir / open file & close" })
        vim.keymap.set("n", "<Esc>", function()
          require("mini.files").close()
        end, { buffer = buf_id, desc = "Close mini.files" })
        vim.keymap.set("n", "<C-v>", function()
          require("mini.files").go_in({ close_on_file = true })
          vim.schedule(function() vim.cmd("vsplit") end)
        end, { buffer = buf_id, desc = "Open in vsplit" })
        vim.keymap.set("n", "<C-x>", function()
          require("mini.files").go_in({ close_on_file = true })
          vim.schedule(function() vim.cmd("split") end)
        end, { buffer = buf_id, desc = "Open in split" })
      end,
    })

    -- mini.files git status overlay
    local nsMiniFiles = vim.api.nvim_create_namespace("mini_files_git")
    local autocmd = vim.api.nvim_create_autocmd
    local MiniFiles = require("mini.files")

    local gitStatusCache = {}
    local cacheTimeout = 2 -- seconds (os.time() returns seconds)

    local function isSymlink(path)
      ---@diagnostic disable-next-line: undefined-field
      local stat = vim.uv.fs_lstat(path)
      return stat and stat.type == "link"
    end

    local function mapSymbols(status, is_symlink)
      local statusMap = {
        [" M"] = { symbol = "", hlGroup = "MiniDepsHint" },
        ["M "] = { symbol = "", hlGroup = "MiniDiffSignAdd" },
        ["MM"] = { symbol = "", hlGroup = "MiniDiffSignChange" },
        ["A "] = { symbol = "", hlGroup = "MiniDiffSignAdd" },
        ["AA"] = { symbol = "≈", hlGroup = "MiniDiffSignAdd" },
        ["D "] = { symbol = "-", hlGroup = "MiniDiffSignDelete" },
        ["AM"] = { symbol = "⊕", hlGroup = "MiniDiffSignChange" },
        ["AD"] = { symbol = "-•", hlGroup = "MiniDiffSignChange" },
        ["R "] = { symbol = "→", hlGroup = "MiniDiffSignChange" },
        ["U "] = { symbol = "‖", hlGroup = "MiniDiffSignChange" },
        ["UU"] = { symbol = "⇄", hlGroup = "MiniDiffSignAdd" },
        ["UA"] = { symbol = "⊕", hlGroup = "MiniDiffSignAdd" },
        ["??"] = { symbol = "", hlGroup = "MiniDepsPlaceholder" },
        ["!!"] = { symbol = "", hlGroup = "MiniIconsAzure" },
      }

      local result = statusMap[status] or { symbol = "?", hlGroup = "NonText" }
      local gitSymbol = result.symbol
      local gitHlGroup = result.hlGroup
      local symlinkSymbol = is_symlink and "↩" or ""
      local combinedSymbol = (symlinkSymbol .. gitSymbol):gsub("^%s+", ""):gsub("%s+$", "")
      local combinedHlGroup = is_symlink and "MiniDiffSignDelete" or gitHlGroup
      return combinedSymbol, combinedHlGroup
    end

    local function fetchGitStatus(cwd, callback)
      local clean_cwd = cwd:gsub("^minifiles://%d+/", "")
      local function on_exit(content)
        if content.code == 0 then
          callback(content.stdout)
        end
      end
      vim.system({ "git", "status", "--ignored", "--porcelain" }, { text = true, cwd = clean_cwd }, on_exit)
    end

    local function updateMiniWithGit(buf_id, gitStatusMap)
      vim.schedule(function()
        local nlines = vim.api.nvim_buf_line_count(buf_id)
        local cwd = vim.fs.root(buf_id, ".git")
        local escapedcwd = cwd and vim.pesc(cwd)
        if not escapedcwd then
          return
        end
        escapedcwd = vim.fs.normalize(escapedcwd)

        for i = 1, nlines do
          ---@diagnostic disable-next-line: need-check-nil
          local entry = MiniFiles.get_fs_entry(buf_id, i)
          if not entry then
            break
          end
          local relativePath = entry.path:gsub("^" .. escapedcwd .. "/", "")
          local status = gitStatusMap[relativePath]

          if status then
            local symbol, hlGroup = mapSymbols(status, isSymlink(entry.path))
            vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
              sign_text = symbol,
              sign_hl_group = hlGroup,
              priority = 2,
            })
            local line = vim.api.nvim_buf_get_lines(buf_id, i - 1, i, false)[1]
            if not line then
              break
            end
            ---@diagnostic disable-next-line: need-check-nil
            local nameStartCol = line:find(vim.pesc(entry.name)) or 0
            if nameStartCol > 0 then
              vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, nameStartCol - 1, {
                end_col = nameStartCol + #entry.name - 1,
                hl_group = hlGroup,
              })
            end
          end
        end
      end)
    end

    local function parseGitStatus(content)
      local gitStatusMap = {}
      for line in content:gmatch("[^\r\n]+") do
        local status, filePath = string.match(line, "^(..)%s+(.*)")
        if not status or not filePath then
          goto continue
        end
        local parts = {}
        for part in filePath:gmatch("[^/]+") do
          table.insert(parts, part)
        end
        local currentKey = ""
        for i, part in ipairs(parts) do
          if i > 1 then
            currentKey = currentKey .. "/" .. part
          else
            currentKey = part
          end
          if i == #parts then
            gitStatusMap[currentKey] = status
          else
            if not gitStatusMap[currentKey] then
              gitStatusMap[currentKey] = status
            end
          end
        end
        ::continue::
      end
      return gitStatusMap
    end

    local function updateGitStatus(buf_id)
      if not vim.fs.root(buf_id, ".git") then
        return
      end
      local cwd = vim.fs.root(buf_id, ".git")
      if not cwd then
        return
      end

      local currentTime = os.time()

      if gitStatusCache[cwd] and currentTime - gitStatusCache[cwd].time < cacheTimeout then
        updateMiniWithGit(buf_id, gitStatusCache[cwd].statusMap)
      else
        fetchGitStatus(cwd, function(content)
          local gitStatusMap = parseGitStatus(content)
          gitStatusCache[cwd] = {
            time = currentTime,
            statusMap = gitStatusMap,
          }
          updateMiniWithGit(buf_id, gitStatusMap)
        end)
      end
    end

    local function clearCache()
      gitStatusCache = {}
    end

    local function gitaug(name)
      return vim.api.nvim_create_augroup("MiniFiles_" .. name, { clear = true })
    end

    autocmd("User", {
      group = gitaug("start"),
      pattern = "MiniFilesExplorerOpen",
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        updateGitStatus(bufnr)
      end,
    })

    autocmd("User", {
      group = gitaug("close"),
      pattern = "MiniFilesExplorerClose",
      callback = function()
        clearCache()
      end,
    })

    autocmd("User", {
      group = gitaug("update"),
      pattern = "MiniFilesBufferUpdate",
      callback = function(args)
        local bufnr = args.data.buf_id
        local cwd = vim.fs.root(bufnr, ".git")
        if gitStatusCache[cwd] then
          updateMiniWithGit(bufnr, gitStatusCache[cwd].statusMap)
        end
      end,
    })
  end,
}
