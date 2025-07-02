"# 説明
" vim,nvim どちらでも挙動するように設定している

" 設定を有効にする場合
" ln -sf nvim.minimal/init.vim ~/.vimrc
" ln -sf nvim.minimal ~/.config/nvim

" コピーが不可能等の理由で設定を指定したい場合
" vim -u init.vim
" nvim -u init.vim


"# 設定

" バッファ文字コード
set encoding=utf-8

" 書き込み文字コード
set fileencodings=utf-8

" 読み込み文字コード
set fileencodings=utf-8,cp932,sjis,euc-jp,latin1

" 改行コード
" 自分はwinでもwls利用しているため全環境でLF優先
set fileformats=unix,dos,mac

" 行番号表示
set number

" 情報表示
set laststatus=2

" シンタックスハイライト
syntax enable

" 全角文字表示設定
set ambiwidth=double

"インデントの設定

" 言語ごとのインデントの設定
filetype indent on

" インデントはスペース
set expandtab

" tab長
set tabstop=4

" インデントスペース数
set shiftwidth=4

" 改行インデント
set autoindent

" eobの文字を~から-に変更
set fillchars+=eob:-

" 検索

" インクリメンタル検索しない
set noincsearch

" 検索結果ハイライト
set hlsearch

" 検索で大文字小文字を区別しない
set ignorecase

" 検索がファイル末尾まで進んだらファイル先頭から再開
set wrapscan

" end

