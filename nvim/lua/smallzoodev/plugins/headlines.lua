return {
  "lukas-reineke/headlines.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  ft = { "markdown", "org" },
  config = function()
    require("headlines").setup({
      markdown = {
        headline_highlights = {
          "Headline1",
          "Headline2",
          "Headline3",
          "Headline4",
          "Headline5",
          "Headline6",
        },
        bullets = { "󰉫", "󰉬", "󰉭", "󰉮", "󰉯", "󰉰" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        quote_highlight = "Quote",
      },
    })

    -- Coolnight theme colors
    vim.cmd([[
      highlight Headline1 guibg=#033259 guifg=#44FFB1 gui=bold
      highlight Headline2 guibg=#032541 guifg=#24EAF7 gui=bold
      highlight Headline3 guibg=#032036 guifg=#0FC5ED gui=bold
      highlight Headline4 guibg=#02182b guifg=#a277ff
      highlight Headline5 guibg=#021520 guifg=#FFE073
      highlight Headline6 guibg=#011423 guifg=#CBE0F0
      highlight CodeBlock guibg=#021520
      highlight Dash guifg=#214969
      highlight Quote guifg=#24EAF7 gui=italic
    ]])
  end,
}
