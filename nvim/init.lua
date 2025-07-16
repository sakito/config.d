-- 高速化 Lua module loader
if vim.loader then
  vim.loader.enable()
end

-- load
require("preface").setup()
require("lazy_vim")
require("option").setup()
require("key").setup()

