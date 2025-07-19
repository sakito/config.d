return {
  {
    "lambdalisue/vim-gin",
    dependencies = {
      "vim-denops/denops.vim",
    },
    lazy = true,
    event = { "BufRead", "CursorHold" },
    config = function()
      require("config.gin")
    end,
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    event = { "BufRead", "CursorHold" },
  },
}
