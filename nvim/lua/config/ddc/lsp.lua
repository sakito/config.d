-- オリジナル: https://github.com/koralle/dotfiles-nixos/blob/main/users/koralle/.config/nvim/lua/plugins/ddc/source-lsp.lua

local helper = require("helper.ddc")

helper.patch_global({
  sourceOptions = {
    lsp = {
      mark = "[LSP]",
      dup = "keep",
      keywordPattern = "\\k+",
      sorters = {
        "sorter_lsp-kind",
      },
      converters = {
        "converter_kind_labels",
      },
    },
  },
  sourceParams = {
    lsp = {
      lspEngine = "nvim-lsp",
      snippetEngine = vim.fn["denops#callback#register"](function(body)
        vim.fn["vsnip#anonymous"](body)
      end),
      enableResolveItem = true,
      enableAdditionalTextEdit = true,
      confirmBehavior = "replace",
    },
  },
})
