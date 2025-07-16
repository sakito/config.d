return {
  {
    "Shougo/ddu.vim",
    dependencies = {
      "denops.vim",

      -- ui
      "Shougo/ddu-ui-filer",
      "Shougo/ddu-ui-ff",

      "ryota2357/ddu-column-icon_filename",

      -- filter
      "Shougo/ddu-filter-matcher_substring",

      -- kind
      "Shougo/ddu-kind-file",

      -- source
      "Shougo/ddu-source-action",
      "Shougo/ddu-source-file",
      "shun/ddu-source-buffer",
      "matsui54/ddu-source-help",
      "matsui54/ddu-source-file_external",
      "shun/ddu-source-rg",
      "kuuote/ddu-source-mr",
      "Shougo/ddu-source-dummy",

      -- "Shougo/ddu-source-file_rec", file_external を利用するならおそらく不要

      -- Command
      "Shougo/ddu-commands.vim",
      "matsui54/ddu-source-command_history",

      -- dduのpluginでない物
      "lambdalisue/vim-mr",
      "lambdalisue/vim-kensaku",
      "lambdalisue/vim-kensaku-search",
    },
    lazy = false,
    config = function()
      require("config.ddu.init").setup()
    end,
  },
  {
    "uga-rosa/ddu-source-lsp",
    dependencies = {
      "Shougo/ddu.vim",
    },
    config = function()
      require("config.ddu.lsp")
    end,
  },
}
