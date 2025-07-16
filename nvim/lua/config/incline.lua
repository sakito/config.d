local helpers = require("incline.helpers")
local devicons = require("nvim-web-devicons")

require("incline").setup({
  window = {
    padding = 0,
    margin = { horizontal = 0 },
  },
  render = function(props)
    -- ファイル名
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    if filename == "" then
      filename = "[No Name]"
    end

    -- icon
    local ft_icon, ft_color = devicons.get_icon_color(filename)

    -- 変更の判定
    local modified = vim.bo[props.buf].modified
    local mark = modified and "" or ""
    -- フォーカスの判定
    local focus = props.focused

    return {
      ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
      " ",
      filename,
      " ",
      guibg = focus and "#bdd1dd" or "#e4dcd4",
      mark and { " ", mark, guibg = modified and "#DD5522" or "#00FF00" } or "",
    }
  end,
})
