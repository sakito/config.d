-- オリジナル: https://github.com/koralle/dotfiles-nixos/blob/main/users/koralle/.config/nvim/lua/plugins/ddu/source-dummy.lua

local M = {}

local helper = require("helper.ddu")

local function is_dummy(items, index)
  return items[index] and items[index].__sourceName == "dummy"
end

local function move_ignore_dummy(dir)
  return function()
    local items = vim.fn["ddu#ui#get_items"]()
    local index = vim.fn.line(".") + dir

    while is_dummy(items, index) do
      index = index + dir
    end
    if 1 <= index and index <= #items then
      vim.cmd("normal! " .. index .. "gg")
    end
  end
end

local ddu_dummy = function()
  helper.ff_map("dummy", function(map)
    map("j", move_ignore_dummy(1))
    map("k", move_ignore_dummy(-1))
  end)
end

function M.setup()
  ddu_dummy()
end

return M
