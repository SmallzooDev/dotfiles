return {
  "jpalardy/vim-slime",
  ft = { "racket", "scheme", "sql" },
  init = function()
    vim.g.slime_target = "tmux"
    vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
    vim.g.slime_dont_ask_default = 1

    local function send_and_focus(plug)
      return function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(plug, true, false, true), "x", false)
        local cfg = vim.b.slime_config or vim.g.slime_default_config
        vim.system({ "tmux", "select-pane", "-t", cfg.target_pane })
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
