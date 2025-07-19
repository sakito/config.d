-- ff設定

local M = {}

local bufmap = require("helper.keymap").bufmap()
local sep = require("helper.ddu").ff_sep
local do_action = vim.fn["ddu#ui#do_action"]

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

function M.setup()
  ddu_ff()
  ddu_ff_filter()
  ddu_help()
  ddu_buffer()
end

return M
