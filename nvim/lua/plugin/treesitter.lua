return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = { "BufRead", "CursorHold" },
    ft = { "help" },
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },
  {
    "yioneko/nvim-yati",
    lazy = true,
    event = { "BufRead", "CursorHold" },
    requires = "nvim-treesitter/nvim-treesitter",
  }
}
