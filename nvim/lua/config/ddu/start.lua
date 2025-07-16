-- 起動キー設定
-- 各種設定は個別の関数で実施する方向

local M = {}

local map = require("helper.keymap").map()

local ddu = {
  start = vim.fn["ddu#start"],
}

function M.setup()
  map("n", ";;", function()
    return ddu.start({ name = "ff" })
  end)
  map("n", ";b", function()
    return ddu.start({ name = "buffer-ff" })
  end)
  map("n", ";h", function()
    return ddu.start({ name = "help-ff" })
  end)

  require("config/ddu/filer").setup()

  map("n", ";o", function()
    return ddu.start({ name = "lsp:definition_all" })
  end)
end

return M
