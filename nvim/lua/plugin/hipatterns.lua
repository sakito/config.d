return {
  "echasnovski/mini.hipatterns",
  version = "*",
  lazy = true,
  event = { "BufRead", "CursorHold" },
  config = function()
    require("config.hipatterns")
  end,
}
