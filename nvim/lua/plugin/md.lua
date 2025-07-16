-- markdown

return {
  "ixru/nvim-markdown",
  ft = { "markdown" },
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("config.md")
  end,
}
