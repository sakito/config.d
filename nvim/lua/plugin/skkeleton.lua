return {

  {
    "vim-skk/skkeleton",
    -- skkserver利用時lazyにするとかたまる？
    --lazy = true,
    --event= {"InsertEnter"},
    config = function()
      require("hook.skkeleton").setup()
    end,
  },

  {
    "delphinus/skkeleton_indicator.nvim",
    --lazy = true,
    dependencies = {
      "vim-skk/skkeleton",
    },
    config = function()
      require("hook.skkeleton_indicator").setup()
    end,
  },

}
