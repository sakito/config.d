return {
  "akinsho/bufferline.nvim",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require("hook.bufferline")
  end,
}
