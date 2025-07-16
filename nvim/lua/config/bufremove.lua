require("mini.bufremove").setup()

vim.api.nvim_create_user_command("Bufdelete", function()
  MiniBufremove.delete()
end, { desc = "Remove buffer" })
