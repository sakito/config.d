-- Copyright (C) 2025 sakito <sakito@sakito.com>
-- MIT License
-- <https://opensource.org/license/mit>

-- 前処理関連

local M = {}

function M.setup()
  -- mapleader関連設定
  -- lazyより先に呼ぶ必要がある
  vim.g.mapleader = "," -- カンマ
  -- vim.g.mapleader = " " -- スペース
  vim.g.maplocalleader = "\\"
end

return M
