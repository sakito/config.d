-- Copyright (C) 2025 sakito <sakito@sakito.com>
-- MIT License
-- <https://opensource.org/license/mit>

-- キー関連設定

-- mode 一覧
-- n: normal
-- i: insert
-- c: comand-line
-- v: visual, select
-- x: vusual
-- s: select
-- o: operator-pending
-- t: terminal
-- l: insert, comand-line, lang-arg
-- 空: 何も指定しない場合 n, v, o 指定と同じ挙動

local M = {}

function M.setup()
  local map = require("helper.keymap").map()

  --# 無効
  -- ddu、ddc系に利用
  map("n", ";", "<nop>")
  -- s = cl、clしか使わないのでs無効にして利用している
  -- buffer、window、tab系に利用
  map("n", "s", "<nop>")
  -- shift + q: exで編集、q: マクロ、だがQをqにして、qは無効化
  map("n", "q", "<nop>")
  map("n", "Q", "q")

  --# 基本操作

  -- write
  map({ "n", "i" }, "<leader>w", "<cmd>write<cr>")
  map("v", "<leader>w", "<c-c><cmd>write<cr>")
  map("o", "<leader>w", "<esc><cmd>write<cr>")

  -- buffer削除 mini.bufremove の機能に割り当て
  --map({ "n", "i" }, "<leader>q", "<cmd>bdelete<cr>")
  map({ "n", "i" }, "<leader>q", "<cmd>Bufdelete<cr>")

  -- コメントアウト nvim 0.11 標準機能
  map("n", "<leader>c;", ":normal gcc<cr>")
  map("v", "<leader>c;", "<esc>:normal gvgc<cr>")

  -- x の挙動を変更
  map({ "n", "x" }, "x", '"_x')
  --map("n", "X", '"_D')
  map("o", "x", "d")

  -- redo
  map("n", "U", "<c-r>")

  -- paste p を P の挙動にする 設定してみたが慣れないのでoffにしている
  --map("x", "p", "P")

  -- indent
  map("n", "<Tab>", ">>")
  map("n", "<S-Tab>", "<<")
  map("v", "<Tab>", ">gv")
  map("v", "<S-Tab>", "<gv")

  -- select
  -- 矩形選択モード
  map({ "n", "x" }, "r", "<c-v>")

  -- redraw
  map("n", "<c-l>", "<cmd>redraw!<cr>")

  -- esc関連
  -- skk起動時はascii状態でないと打てない
  map({ "i", "x", "v", "o" }, "jj", "<esc>")
  map("i", "j ", "j")
  map("n", "<esc>", "<cmd>nohlsearch<cr>")
  -- コマンドモードでは<esc>割り当ては改行と同じになるので割り当てない、c-cを割り当てる
  map("c", "<c-g>", "<c-c>")

  --# 移動系

  -- 見た目の行でカーソル移動
  map("n", "j", "gj")
  map("v", "j", "gj")
  map("n", "k", "gk")
  map("v", "k", "gk")

  -- i 時のカーソル移動 Emacs like
  -- 癖で打鍵するので対処
  -- c-n、c-p は ddc の方で設定しているのでここではoff
  --map("i", "<c-n>", "<Down>")
  --map("i", "<c-p>", "<Up>")
  map({ "i", "n" }, "<c-f>", "<Right>")
  map({ "i", "n" }, "<c-b>", "<Left>")

  map("i", "<c-a>", "<Home>")
  map("i", "<c-e>", "<End>")
  map("", "<c-a>", "^")
  map("", "<c-e>", "$")

  -- 画面分割
  -- Emacs c-x 2 上下分割、c-x 3 左右分割、c-x 1 現在window以外閉じる
  -- xにするとミスると削除になるのでsに割り当てている
  -- 現在window以外閉じる
  map("n", "s1", "<C-w>o")
  -- 上下分割
  map("n", "s2", "<C-w>s")
  -- 左右分割
  map("n", "s3", "<C-w>v")

  -- window移動は デフォルト割り当ては c-w w、c-w hjklw
  -- 次windowへ
  map("n", "sw", "<cmd>wincmd w<cr>")

  -- タブ
  map("n", "<leader>sc", ":$tabnew<cr>")
  map("n", "<leader>sk", ":tabclose<cr>")
  map("n", "<leader>sn", ":tabn<cr>")
  -- tabonly, tabp, -tabmove, +tabmove
  -- タブ数が多い場合はddu利用しているのでkeyは割り当ててない

  -- バッファ dduで切り替えているのでキー割り当てしてない

  -- c時設定
  map("c", "<c-a>", "<Home>")
  map("c", "<c-b>", "<Left>")
  map("c", "<c-d>", "<Del>")
  map("c", "<c-f>", "<Right>")
  map("c", "<c-n>", "<Down>")
  map("c", "<c-p>", "<Up>")
  -- <C-k>: Delete to the end
  map("c", "<c-k>", "<cmd>call setcmdline(getcmdpos() ==# 1 ? '' : getcmdline()[:getcmdpos() - 2])<cr>")

  -- 相対行番号のtoggle
  local Toggle_numbering = function()
    if vim.wo.relativenumber then
      vim.cmd("set norelativenumber")
    else
      vim.cmd("set relativenumber")
    end
  end
  map("n", "<leader>n", function()
    return Toggle_numbering()
  end)
end

return M
