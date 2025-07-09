-- Copyright (C) 2025 sakito <sakito@sakito.com>
-- MIT License
-- <https://opensource.org/license/mit>

-- option関連

local M = {}

function M.setup()

  -- バッファ文字コード
  vim.o.encoding = "utf-8"

  -- 書き込み文字コード
  vim.o.fileencodings = "utf-8"

  -- 読み込み文字コード
  vim.o.fileencodings = "utf-8,cp932,sjis,euc-jp,latin1"

  -- 改行コード
  vim.o.fileformats = "unix,dos,mac"

  -- 行番号表示
  vim.o.number = true

  -- 情報表示(3: nvimのみの機能、常時表示)
  vim.o.laststatus = 3

  -- 全角文字表示設定
  vim.o.ambiwidth = "double"

  --# 見た目関連

  -- 色
  vim.o.termguicolors = true

  -- カーソル位置にライン表示
  vim.o.cursorline = true

  -- インデントの設定

  -- インデントはスペース
  vim.o.expandtab = true

  -- tab長
  vim.o.tabstop = 4

  -- インデントスペース数
  vim.o.shiftwidth = 4

  -- 改行インデント
  vim.o.autoindent = true

  -- eobの文字を~から-に変更
  vim.opt.fillchars = {eob = "-"}

  --# 検索

  -- インクリメンタル検索しない
  vim.o.incsearch = false

  -- 検索結果ハイライト
  vim.o.hlsearch = true

  -- 検索で大文字小文字を区別しない
  vim.o.ignorecase = true

  -- 検索がファイル末尾まで進んだらファイル先頭から再開
  vim.o.wrapscan = true


end

return M
