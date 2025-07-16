-- 自作 snippet の場所指定
local dir = vim.fn.stdpath("config") .. "/snippet/"
for name, _ in vim.fs.dir(dir) do
  vim.fn["denippet#load"](dir .. name)
end

-- friendly-snippets の読み込み設定
local options = require("lazy.core.config").options
local root = vim.fs.joinpath(options.root, "friendly-snippets", "snippets")

local ignore = {
  -- 無視するファイル
  "markdown.json",
}

local function is_target(target)
  local flag = true
  for name in vim.iter(ignore) do
    if target == name then
      flag = false
      break
    end
  end
  return flag
end


for name_l1, type_l1 in vim.fs.dir(root) do
  if type_l1 == "file" then
    if is_target(name_l1) then
      vim.fn["denippet#load"](vim.fs.joinpath(root, name_l1))
    end
  elseif type_l1 == "directory" then
    local dirname = name_l1
    for name_l2, type_l2 in vim.fs.dir(vim.fs.joinpath(root, dirname)) do
      if type_l2 == "file" then
        vim.fn["denippet#load"](vim.fs.joinpath(root, dirname, name_l2))
      end
    end
  end
end


local map = require("helper.keymap").map()

-- キー設定
map("i", "<leader>o", "<Plug>(denippet-expand)")
