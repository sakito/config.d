return {
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
    "Shougo/ddu-source-file",
    "shun/ddu-source-buffer",

    "matsui54/ddu-source-help",

    -- "Shougo/ddu-source-file_rec", file_external を利用するならおそらく不要
    "matsui54/ddu-source-file_external",
    "shun/ddu-source-rg",

    -- dduのpluginでない物
    "lambdalisue/vim-mr",
    "lambdalisue/vim-kensaku",
    "lambdalisue/vim-kensaku-search",
  },
  lazy = false,
  config = function()
    require("hook.ddu").setup()
  end,
}
