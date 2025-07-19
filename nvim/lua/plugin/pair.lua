return {
  {
    "cohama/lexima.vim",
    lazy = true,
    event = { "InsertEnter" },
    config = function()
      require("config.lexima")
    end,
  },
  {
    "machakann/vim-sandwich",
    lazy = true,
    event = { "InsertEnter" },
  },
}
