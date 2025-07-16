return {
  "EdenEast/nightfox.nvim",
  tag = "v3.10.0",
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme dayfox]])
    vim.api.nvim_set_hl(0, "MatchParen", { bg = "#352c24", fg = "#f2e9e1" })
  end,
}
