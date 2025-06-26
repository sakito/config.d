-- 高速化 Lua module loader
if vim.loader then
  vim.loader.enable()
end

-- 起動時cd
vim.cmd([[autocmd VimEnter * cd ~]])

-- vim基本設定
vim.cmd([[syntax enable]])
vim.cmd([[filetype plugin indent on]])

-- denops
local denops = vim.fn.expand(
  vim.fs.joinpath(vim.fn.stdpath("cache"),
                  "dpp/repos/github.com/vim-denops/denops.vim"))
vim.opt.runtimepath:prepend(denops)
