return {
  "Shougo/ddc.vim",

  lazy = false,
  dependencies = {
    "vim-denops/denops.vim",

    -- ui
    "Shougo/ddc-ui-pum",
    "Shougo/pum.vim",

    -- source
    "Shougo/ddc-source-around",
    "Shougo/ddc-source-cmdline",
    "LumaKernel/ddc-source-file",

    -- filter
    "Shougo/ddc-filter-converter_remove_overlap",
    "tani/ddc-fuzzy",
    "Shougo/ddc-filter-sorter_rank",
    "Shougo/ddc-filter-matcher_head",
  },
  config = function()
    require("hook.ddc").setup()
  end,
  keys = {
    { "<S-Tab>", "<Cmd>call pum#map#insert_relative(-1)<CR>", mode = "i" },
    { "<C-n>", "<Cmd>call pum#map#select_relative(+1)<CR>", mode = "i" },
    { "<C-p>", "<Cmd>call pum#map#select_relative(-1)<CR>", mode = "i" },
    { "<C-y>", "<Cmd>call pum#map#confirm()<CR>", mode = "i" },
    { "<C-e>", " <Cmd>call pum#map#cancel()<CR>", mode = "i" },
  },
}
