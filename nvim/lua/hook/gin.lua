-- 確認なしで変更を適用
vim.g.gin_proxy_apply_without_confirm = true


-- キー設定
vim.keymap.set("n",  "<leader>g", "<Cmd>GinStatus<CR>")

-- FileTypeがわからない場合は :lua print(vim.bo.filetype)
vim.g.gin_status_disable_default_mappings = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gin-status",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = true })
    end

  bufmap("n", "?", "<Plug>(gin-action-help)")
  bufmap({ "n", "x" }, "a", "<Plug>(gin-action-choice)")

  -- コメント書いて :wq でコミット
  bufmap("n", "cc", "<cmd>Gin commit -v<cr>")

  bufmap("n", "d", "<Plug>(gin-action-diff:smart)")
  bufmap("n", "L", "<cmd>GinLog --graph --oneline<cr>")
  bufmap("n", "P", "<cmd>Gin push<cr>")
  bufmap("n", "q", "<cmd>bd<cr>")
  bufmap({ "n", "x" }, "s", "<Plug>(gin-action-stage)")
  bufmap({ "n", "x" }, "u", "<Plug>(gin-action-unstage)")
  bufmap("n", "y", "<Plug>(gin-action-yank:path)")

  end,
})


vim.g.gin_diff_disable_default_mappings = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gin-diff",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = true })
    end

  bufmap("n", "?", "<Plug>(gin-action-help)")
  bufmap({ "n", "x" }, "a", "<Plug>(gin-action-choice)")

  bufmap("n", "q", "<cmd>bd<cr><Cmd>GinStatus<Cr>j")

  end,
})

vim.g.gin_log_disable_default_mappings = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gin-log",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = true })
  end

  bufmap("n", "?", "<Plug>(gin-action-help)")
  bufmap({ "n", "x" }, "a", "<Plug>(gin-action-choice)")

  bufmap("n", "q", "<cmd>bd<cr><Cmd>GinStatus<Cr>j")

  bufmap("n", "y", "<Plug>(gin-action-yank:commit)")

  end,
})
