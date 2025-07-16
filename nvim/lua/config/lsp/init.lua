local servers = {
  -- lua
  "lua_ls",

  -- TS(Deno)
  "denols",

  -- Python
  "pyright",
}

vim.lsp.config("*", {
  capabilities = require("ddc_source_lsp").make_client_capabilities(),
})

vim.diagnostic.config({
  -- 仮想テキストを表示
  virtual_text = true,
  -- サインを表示
  signs = true,
  -- 挿入モード中に更新しない
  update_in_insert = false,
  -- 重み付けでソート
  severity_sort = true,
})

vim.lsp.enable(servers)

require("config.lsp.lua_ls")
