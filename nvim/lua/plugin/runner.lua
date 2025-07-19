return {
  {
    "stevearc/overseer.nvim",
    keys = {
      { "<leader>r", "<CMD>OverseerRun<CR>" },
      { "<leader>R", "<CMD>OverseerToggle<CR>" },
    },
    config = function()
      require("config.overseer")
    end,
  },
  {
    "vim-test/vim-test",
    lazy = true,
    event = { "BufRead", "CursorHold" },
  },
}
