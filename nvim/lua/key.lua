-- Copyright (C) 2025 sakito <sakito@sakito.com>
-- MIT License
-- <https://opensource.org/license/mit>

-- キー関連設定

local M = {}

local map = function(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = true })
end

function M.setup()

  -- esc関連
  -- コマンドモードでは<esc>割り当ては改行と同じになるので割り当てできない
  -- skk起動時はascii状態でないと打てない
  map("i", "<c-g>", "<esc>")
  map("i", "jj", "<esc>")
  map("x", "<c-g>", "<esc>")
  map("i", "jj", "<esc>")
  map("n", "<esc>", "<cmd>nohlsearch<cr>")

  -- i 時のカーソル移動 Emacs like
  -- 癖で打鍵するので対処
  map("i", "<c-n>", "<Down>")
  map("i", "<c-p>", "<Up>")
  map("i", "<c-f>", "<Right>")
  map("i", "<c-b>", "<Left>")

  -- 画面分割
  -- Emacs c-x 2 上下分割、c-x 3 左右分割、c-x 1 現在window以外閉じる
  -- 現在window以外閉じる
  map("n", "<leader>x1", "<C-w>o")
  -- 上下分割
  map("n", "<leader>x2", "<C-w>s")
  -- 左右分割
  map("n", "<leader>x3", "<C-w>v")

  -- window移動は c-w w、c-w hjklw
  -- 次windowへ
  map("n", "<leader>wn", "<C-w>w")

  -- バッファ
  map("n", "<leader>bk", "<cmd>bdelete<cr>")
  map("n", "<leader>bn", "<cmd>bnext<cr>")
  map("n", "<leader>bp", "<cmd>bprevious<cr>")

end


return M
