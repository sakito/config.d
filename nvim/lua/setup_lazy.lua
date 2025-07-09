-- lazy導入時にあらかじめ実行しておくluaファイル

if vim.loader then
  vim.loader.enable()
end

local joinpath = vim.fs.joinpath

local cache_dir = joinpath(vim.fn.stdpath("cache"), "lazy")
local targets = {
  {
    host = "github.com",
    path = "folke/lazy.nvim",
    branch = "v11.17.1",
  },
}

-- git clone
for idx, target in pairs(targets) do
  local target_path = joinpath(cache_dir, "repos", target.path)
  local target_url = "https://" .. target.host .. "/" .. target.path

  print(target_path)
  print(target_url)

  if not (vim.uv or vim.loop).fs_stat(target_path) then
    if vim.fn.isdirectory(target_path) ~= 1 then
      local cmd_t = {
        "git",
        "clone",
        "--filter=blob:none",
        "--branch",
        target.branch,
        target_url,
        target_path,
      }

      vim.fn.system(cmd_t)
    end
  end
end
