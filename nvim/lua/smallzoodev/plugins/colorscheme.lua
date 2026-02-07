return {
  "slugbyte/lackluster.nvim",
  priority = 1000,
  config = function()
    package.loaded["lackluster.plugin.bufferline"] = function() end

    local lackluster = require("lackluster")

    lackluster.setup({
      tweak_highlight = {
        LspReferenceText = { overwrite = true, bg = "#2a2a2a", underline = false },
        LspReferenceRead = { overwrite = true, bg = "#2a2a2a", underline = false },
        LspReferenceWrite = { overwrite = true, bg = "#444444", underline = false },
      },
    })

    vim.cmd("colorscheme lackluster-hack")
  end,
}
