return {
  "jpalardy/vim-slime",
  ft = { "racket", "scheme", "sql" },
  init = function()
    vim.g.slime_target = "tmux"
    vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
    vim.g.slime_dont_ask_default = 1

    local function pane_tty(target)
      local tty = vim.fn.system({ "tmux", "display", "-p", "-t", target, "#{pane_tty}" })
      return (tty:gsub("%s", ""):gsub("^/dev/", ""))
    end

    local function pspg_open(tty)
      if tty == "" then
        return false
      end
      return vim.fn.system({ "ps", "-t", tty, "-o", "comm=" }):match("pspg") ~= nil
    end

    local function send_and_focus(plug)
      return function()
        local cfg = vim.b.slime_config or vim.g.slime_default_config
        local target = cfg.target_pane
        local tty = pane_tty(target)
        if pspg_open(tty) then
          vim.fn.system({ "tmux", "send-keys", "-t", target, "q" })
          vim.wait(500, function()
            return not pspg_open(tty)
          end, 50)
        end
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(plug, true, false, true), "x", false)
        vim.system({ "tmux", "select-pane", "-t", target })
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "sql",
      callback = function(args)
        vim.keymap.set("n", "<leader><CR>", send_and_focus("<Plug>SlimeParagraphSend"), { buffer = args.buf, desc = "Send paragraph to psql pane" })
        vim.keymap.set("x", "<leader><CR>", send_and_focus("<Plug>SlimeRegionSend"), { buffer = args.buf, desc = "Send selection to psql pane" })
      end,
    })
  end,
}
