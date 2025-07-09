-- lazy
local M = {}

local join = vim.fs.joinpath
local rtp = vim.opt.runtimepath

-- base
local base_dir = join(vim.fn.stdpath("cache"), "lazy")
local repo_dir = join(base_dir, "repos")

-- plugin
local target_dir = join(
  repo_dir, "lazy.nvim")
rtp:prepend(target_dir)

-- 設定
require("lazy").setup({
    root = join(vim.fn.stdpath("cache"), "lazy", "repos"),
    lockfile = join(vim.fn.stdpath("config"), "log", "lazy-lock.json"),
    concurrency = 10,
    checker = { enabled = true },
    log = { level = "info" },
    -- local plugins
    spec = {
      { import = "plugin" },
    }
})

