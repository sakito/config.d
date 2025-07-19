local M = {}

function M.setup()
  -- tsでの設定用
  -- tsで全設定できないため、offにしている
  --local base_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "config")
  --vim.fn["ddu#custom#load_config"](vim.fs.joinpath(base_dir, "ddu.ts"))

  -- 設定読み込み
  require("config.ddu.config").setup()
  require("config.ddu.ff").setup()
  require("config.ddu.dummy").setup()
  require("config.ddu.start").setup()
  require("config.ddu.filer").setup()
  require("config.ddu.lsp").setup()
end

return M
