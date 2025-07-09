return {
  "mvllow/modes.nvim",
  tag = "v0.3.0",
  lazy = true,
  event = {"BufRead", "CursorHold"},
  config = function()
    require("hook.modes")
  end,
}
