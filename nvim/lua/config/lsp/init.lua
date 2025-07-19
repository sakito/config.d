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

-- lsp の設定

-- lua
if vim.fn.executable("lua-language-server") == 1 then
  require("config.lsp.lua_ls")
end

-- TS(Deno)
if vim.fn.executable("deno") == 1 then
  vim.lsp.enable("denols")
end

-- Python
if vim.fn.executable("pyright") == 1 then
  vim.lsp.enable("pyright")
end
