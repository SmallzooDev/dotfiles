return {
  "Olical/conjure",
  ft = { "racket", "scheme" },
  init = function()
    vim.g["conjure#client#racket#stdio#command"] = "racket"
    vim.g["conjure#filetype#scheme"] = "conjure.client.racket.stdio"
  end,
}
