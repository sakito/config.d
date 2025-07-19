local M = {}

local map = require("helper.keymap").map()
local bufmap = require("helper.keymap").bufmap()
local do_action = vim.fn["ddu#ui#do_action"]
local get_item = vim.fn["ddu#ui#get_item"]

local ddu = {
  start = vim.fn["ddu#start"],
}

local ddu_filer_setup = function()
  vim.fn["ddu#custom#patch_local"]("filer", {
    ui = "filer",
    sources = {
      --{ name = "file" },
      { name = "filer_eza" },
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-filer",
    callback = function()
      -- 選択可能action選択
      bufmap("n", "a", function()
        return do_action("chooseAction")
      end)

      bufmap("n", "<Space>", function()
        return do_action("toggleSelectItem")
      end)
      bufmap("n", "o", function()
        return do_action("expandItem", { mode = "toggle" })
      end)

      -- 終了 esc、q両方に割り当て
      bufmap("n", "<ESC>", function()
        return do_action("quit")
      end)
      bufmap("n", "q", function()
        return do_action("quit")
      end)

      -- 誤打鍵たまにするので、全部Shift必要にしている
      bufmap("n", "N", function()
        return do_action("itemAction", { name = "newFile" })
      end)
      bufmap("n", "+", function()
        return do_action("itemAction", { name = "newDirectory" })
      end)
      bufmap("n", "C", function()
        return do_action("itemAction", { name = "copy" })
      end)
      bufmap("n", "P", function()
        return do_action("itemAction", { name = "paste" })
      end)
      bufmap("n", "R", function()
        return do_action("itemAction", { name = "rename" })
      end)
      bufmap("n", "M", function()
        return do_action("itemAction", { name = "move" })
      end)
      bufmap("n", "D", function()
        return do_action("itemAction", { name = "delete" })
      end)

      -- 開くのは cr、tab両方に割り当て
      bufmap("n", "<CR>", function()
        if get_item().isTree then
          do_action("itemAction", { name = "narrow" })
        else
          do_action("itemAction", { name = "open" })
        end
      end)

      bufmap("n", "<tab>", function()
        if get_item().isTree then
          do_action("itemAction", { name = "narrow" })
        else
          do_action("itemAction", { name = "open" })
        end
      end)

      -- h: 上階層、l: 下階層、が普通らしい
      -- この設定は自分用に l: 上階層、 h: 下階層 の逆になっている
      bufmap("n", "h", function()
        if get_item().isTree then
          do_action("itemAction", { name = "narrow" })
        else
          do_action("itemAction", { name = "open" })
        end
      end)

      bufmap("n", "l", function()
        return do_action("itemAction", { name = "narrow", params = { path = ".." } })
      end)

      -- itemの開く閉じる
      bufmap("n", "<C-h>", function()
        return do_action("collapseItem")
      end)
      bufmap("n", "<C-l>", function()
        return do_action("expandItem", { mode = "toggle" })
      end)
    end,
  })
end

local ddu_filer_start = function()
  -- start を呼ぶ直前で取得しないとだめらしい？
  local cur_dir = vim.fn.expand("%:p:h")
  if vim.fn.isdirectory(cur_dir) == 0 then
    -- ファイルが読めない場合 global cwd を開く
    cur_dir = vim.fn.getcwd(-1, -1)
  end
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
  ddu_filer_setup()

  vim.fn["ddu#custom#alias"]("_", "source", "filer_eza", "file_external")

  map("n", ";f", function()
    return ddu_filer_start()
  end)
end

return M
