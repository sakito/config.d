local M = {}

function M.helper()
  local helper = {}

  for _, mode in pairs({ "n", "v", "i", "s", "o", "c", "t", "x" }) do
    helper[mode .. "map"] = function(lhs, rhs, opts)
      vim.keymap.set(mode, lhs, rhs, opts or { silent = true })
    end
  end

  return helper
end

function M.map()
  -- 全体用

  local map = function(mode, lhs, rhs, opts)

    opts = opts or { silent = true }

    -- デフォルト noremap: true, silent: false, buffer: false
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  return map
end

function M.bufmap()
  -- buffer用

  local bufmap = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = true })
  end

  return bufmap
end

return M
