return {
  "mikavilpas/yazi.nvim",
  tag = "v11.6.0",

  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  lazy = true,
  event = { "VeryLazy" },
  opts = {
    open_for_directories = false,

    highlight_groups = {
      hovered_buffer = nil,
      hovered_buffer_in_same_directory = nil,
    },

    yazi_floating_window_scaling_factor = 0.9,

    --yazi_floating_window_winblend = 80,

    yazi_floating_window_border = "rounded",
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
