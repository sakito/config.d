return {
  "cohama/lexima.vim",
  lazy = true,
  event = { "InsertEnter" },
  config = function()
    require("config.lexima")
  end,
}
