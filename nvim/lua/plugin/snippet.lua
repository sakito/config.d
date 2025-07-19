return {
  {
    "uga-rosa/denippet.vim",
    event = { "User DenopsReady" },
    dependencies = {
      "vim-denops/denops.vim",
    },
    config = function()
      require("config.denippet")
    end,
  },
  {
    "rafamadriz/friendly-snippets",
  },
}
