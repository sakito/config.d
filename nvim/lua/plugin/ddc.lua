return {
  {
    "Shougo/ddc.vim",

    lazy = false,
    dependencies = {
      "vim-denops/denops.vim",
      "matsui54/denops-signature_help",

      -- ui
      "Shougo/ddc-ui-native",
      "Shougo/ddc-ui-pum",
      "Shougo/pum.vim",

      -- source
      "Shougo/ddc-source-around",
      "Shougo/ddc-source-cmdline",
      "Shougo/ddc-source-cmdline_history",
      "LumaKernel/ddc-source-file",
      "Shougo/ddc-source-rg",
      "Shougo/ddc-source-lsp",

      -- filter
      "Shougo/ddc-filter-converter_remove_overlap",
      "tani/ddc-fuzzy",
      "Shougo/ddc-filter-sorter_rank",
      "Shougo/ddc-filter-matcher_head",
    },
    config = function()
      require("config.ddc.init").setup()
    end,
  },
}
