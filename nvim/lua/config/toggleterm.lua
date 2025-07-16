require("toggleterm").setup()

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  hidden = true,
})

function Lazygit_toggle()
  lazygit:toggle()
end

local map = require("helper.keymap").map()

map("n", "<leader>lg", "<cmd>lua Lazygit_toggle()<CR>")
map("n", "<leader>t", "<cmd>ToggleTerm size=40 dir=%:p:h <cr>")
