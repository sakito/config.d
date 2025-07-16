-- 共通設定

local M = {}

function M.setup()
  vim.fn["ddu#custom#patch_global"]({
    ui = "ff",
    uiParams = {
      -- デフォルト
      _ = {
        split = "horizontal",
        splitDirection = "bot",
      },
    },
    kindOptions = {
      lsp = {
        defaultAction = "open",
      },
      lsp_codeAction = {
        defaultAction = "apply",
      },
    },
    sourceOptions = {
      -- デフォルト
      _ = {
        matchers = { "matcher_substring" },
      },
      -- file
      file = {
        columns = {
          "icon_filename",
        },
      },
      -- dummy
      dummy = {
        matchers = {},
        sorters = {},
        converters = {},
      },
    },
    columnParams = {
      -- icon_filename
      icon_filename = {
        defaultIcon = { icon = "" },
      },
    },
  })
end

return M
