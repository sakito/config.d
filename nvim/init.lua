-- 高速化 Lua module loader
if vim.loader then
  vim.loader.enable()
end

-- mapleader
-- lazyより先に呼ぶ必要がある
vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

-- load
require("lazy_vim")
require("option").setup()
require("key").setup()

