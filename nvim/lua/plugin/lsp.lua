return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre" },
  config = function()
    require("config.lsp.init")
  end,
}
