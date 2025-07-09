local M = {}

function M.setup()
  -- base
  local base_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "config")

  vim.fn["ddu#custom#load_config"](vim.fs.joinpath(base_dir, "ddu.ts"))



  local keymap = vim.keymap.set
  local ddu_do_action = vim.fn["ddu#ui#do_action"]

  local function ddu_ff_keymaps()
    keymap("n", "<CR>", function()
             ddu_do_action("itemAction")
    end, { buffer = true })
    keymap("n", "i", function()
             ddu_do_action("openFilterWindow")
    end, { buffer = true })
    keymap("n", "q", function()
             ddu_do_action("quit")
    end, { buffer = true })
  end

  local function ddu_ff_filter_keymaps()
    keymap("i", "<CR>", function()
             vim.cmd.stopinsert()
             ddu_do_action("closeFilterWindow")
    end, { buffer = true })
    keymap("n", "<CR>", function()
             ddu_do_action("cloeFilterWindow")
    end, { buffer = true })
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-ff",
    callback = ddu_ff_keymaps,
  })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-ff-filter",
    callback = ddu_ff_filter_keymaps,
  })

end


return M
