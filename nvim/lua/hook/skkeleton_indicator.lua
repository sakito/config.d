local M = {}

function M.setup()

  -- 色を Emacs ddskk に極力合せる

  --  "ivory4" "gray"
  vim.api.nvim_set_hl(0, "SkkeletonIndicatorEiji",
                      { fg = "#3d2b5a", bg = "#bebebe", bold = true })
  -- "coral4" "pink"
  vim.api.nvim_set_hl(0, "SkkeletonIndicatorHira",
                      { fg = "#3d2b5a", bg = "#ffc0cb", bold = true })
  -- "forestgreen" "green"
  vim.api.nvim_set_hl(0, "SkkeletonIndicatorKata",
                      { fg = "#3d2b5a", bg = "#00ff00", bold = true })
  -- gold
  vim.api.nvim_set_hl(0, "SkkeletonIndicatorZenkaku",
                      { fg = "#3d2b5a", bg = "#ffd700", bold = true })

  require("skkeleton_indicator").setup {
    eijiText = 'AB',
    hiraText = 'あ',
    kataText = 'ア',
    hankataText = 'ｱｨ',
    zenkakuText = 'Ａ',
  }

end

return M
