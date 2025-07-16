-- ff設定

local M = {}

local bufmap = require("helper.keymap").bufmap()
local sep = require("helper.ddu").ff_sep
local do_action = vim.fn["ddu#ui#do_action"]
local get_item = vim.fn["ddu#ui#get_item"]

local ddu_help = function()
  -- help-ff 設定

  vim.fn["ddu#custom#patch_local"]("help-ff", {
    ui = "ff",
    sources = {
      { name = "help" },
    },
    sourceOptions = {
      help = {
        defaultAction = "open",
      },
    },
  })

  -- :Help で起動
  vim.api.nvim_create_user_command("Help", function()
    vim.fn["ddu#start"]({ name = "help-ff" })
  end, {})
end

local ddu_buffer = function()
  -- buffer-ff 設定

  vim.fn["ddu#custom#patch_local"]("buffer-ff", {
    sources = {
      { name = "buffer" },
    },
    sourceOptions = {
      buffer = {
        defaultAction = "open",
      },
    },
  })
end

local ddu_ff = function()
  vim.fn["ddu#custom#patch_local"]("ff", {
    sources = {
      --{ name = "file_rec" },
      sep("buffer"),
      { name = "buffer" },
      sep("mr"),
      { name = "mr" },
    },
    sourceOptions = {
      _ = {
        defaultAction = "open",
      },
    },
    uiParams = {
      ff = {
        prompt = "> ",
        startAutoAction = true,
        autoAction = {
          delay = 0,
          name = "preview",
        },
        displayTree = true,
      },
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-ff",
    callback = function()
      bufmap("n", "<CR>", function()
        return do_action("itemAction")
      end)

      bufmap("n", "i", function()
        return do_action("openFilterWindow")
      end)
      bufmap("n", "p", function()
        return do_action("preview")
      end)
      bufmap("n", "q", function()
        return do_action("quit")
      end)
      bufmap("n", "<ESC>", function()
        return do_action("quit")
      end)
    end,
  })
end

local ddu_ff_filter = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-ff-filter",
    callback = function()
      bufmap("i", "<CR>", function()
        do_action("closeFilterWindow")
        vim.cmd("stopinsert")
      end)
      bufmap("i", "<ESC>", function()
        do_action("closeFilterWindow")
        vim.cmd("stopinsert")
      end)
      bufmap("n", "<ESC>", function()
        return do_action("closeFilterWindow") and do_action("quit")
      end)
      bufmap("n", "q", function()
        return do_action("closeFilterWindow") and do_action("quit")
      end)
    end,
  })
end

local ddu_ff_filer = function()
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

function M.setup()
  ddu_ff()
  ddu_ff_filter()
  ddu_help()
  ddu_ff_filer()
  ddu_buffer()
end

return M
