local M = {}

function M.setup()

  -- Skkeleton キーバインド

  -- I/C <C-j> SKK ON
  vim.keymap.set({ 'i', 'c' }, '<C-j>', '<Plug>(skkeleton-enable)')

  -- I/C <C-l> SKK OFF
  vim.keymap.set({ 'i', 'c' }, '<C-l>', '<Plug>(skkeleton-disable)')

  -- skkeleton 設定 (辞書ファイル等)
  vim.fn['skkeleton#config']({
      -- skkserver利用
      sources = { 'skk_server' },
      -- enter等で確定だけ行う(改行しない)
      eggLikeNewline = true,
      keepState = true,
      showCandidatesCount = 2,
      registerConvertResult = true,
  })

end

return M
