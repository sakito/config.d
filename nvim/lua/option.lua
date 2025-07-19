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

  -- 行相対表示
  -- key.lua の方で、keyで切り替える設定を入れている
  -- vim.opt.relativenumber = true

  -- OSクリップボード連携(両方設定しておいて問題ない)
  vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

  -- マウス操作 無効
  vim.opt.mouse = ""

  -- 情報表示
  vim.o.laststatus = 2

  -- 全角文字表示設定
  -- singleにしておかないとレイアウト崩れが発生する環境がある
  -- ただし、singleにすると一部全角記号等が他文字に重なる現象が発生する
  -- terminalや外部アプリ(lazygit等)を利用する場合はsingleにしておく事
  --vim.o.ambiwidth = "double"
  vim.o.ambiwidth = "single"

  --# 見た目関連

  -- 色
  vim.o.termguicolors = true

  -- カーソル位置にライン表示
  vim.o.cursorline = true

  --# インデントの設定

  -- インデントはスペース
  vim.o.expandtab = true

  -- tab長
  vim.o.tabstop = 2
  -- インデントスペース数
  -- 0 を設定するとtabstopと同じになるため個別設定不要になる
  vim.o.shiftwidth = 0
  -- 連続空白でtabでカーソル移動する幅
  -- マイナス値を設定するとshiftwidthと同じになるため個別設定不要になる
  vim.o.softtabstop = -1

  -- smartindent
  vim.o.smartindent = true

  -- 改行インデント
  vim.o.autoindent = true

  -- indent例外
  vim.api.nvim_create_augroup("indent", {})
  vim.api.nvim_create_autocmd("FileType", {
    group = "indent",
    pattern = "go",
    callback = function()
      vim.cmd([[ set noexpandtab tabstop=2 ]])
    end,
  })

  --# 特殊文字関連

  -- eobの文字を~から-に変更
  vim.opt.fillchars = {
    eob = "-",
  }

  -- 制御文字表示
  vim.opt.listchars = {
    tab = ">_",
    trail = "_",
    -- eol = "$",
  }
  vim.opt.list = true

  --# 検索

  -- インクリメンタル検索しない
  vim.o.incsearch = false

  -- 検索結果ハイライト
  vim.o.hlsearch = true

  -- 検索で大文字小文字を区別しない
  vim.o.ignorecase = true

  -- 検索がファイル末尾まで進んだらファイル先頭から再開
  vim.o.wrapscan = true

  -- 復元用ファイル制御
  -- 自動読み込みは許可
  vim.o.autoread = true
  -- backup等のファイルは作成しない
  vim.o.backup = false
  vim.o.writebackup = false
  vim.o.swapfile = false
  vim.o.undofile = false
end

return M
