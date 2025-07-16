local M = {}

local map = require("helper.keymap").map()

local ddu = {
  start = vim.fn["ddu#start"],
}

local ddu_filer = function()
  -- start を呼ぶ直前で取得しないとだめらしい？
  local cur_dir = vim.fn.expand("%:p:h")
  ddu.start({
    name = "filer_eza",
    ui = "filer",
    uiParams = {
      filer = {
        split = "floating",
      },
    },
    sources = {
      { name = "filer_eza" },
    },
    sourceParams = {
      filer_eza = {
        cmd = { "eza", "-1", "-a", "--group-directories-first", "--git-ignore" },
      },
    },
    sourceOptions = {
      filer_eza = {
        path = cur_dir,
        columns = {
          "icon_filename",
        },
      },
    },
  })
end

function M.setup()
  vim.fn["ddu#custom#alias"]("_", "source", "filer_eza", "file_external")

  map("n", ";f", function()
    return ddu_filer()
  end)
end

return M
