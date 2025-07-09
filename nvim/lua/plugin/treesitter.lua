return {
  "nvim-treesitter/nvim-treesitter",
  lazy = true,
  event = {"BufRead", "CursorHold"},
  ft = {"help"},
  build = ":TSUpdate",
  config = function()
    require("hook.treesitter")
  end,
}
