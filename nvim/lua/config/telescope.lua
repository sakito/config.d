local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.keymap.set("n", "<Leader>fx", builtin.commands, { desc = "[C]ommands" })
vim.keymap.set("n", "<Leader>fs", builtin.builtin, { desc = "List Telescope Bultin" })
vim.keymap.set("n", "<Leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer]" })

require("telescope").setup({
  defaults = {
    file_ignore_patterns = {
      -- 検索除外
      "^.git/",
      "^.hg/",
      "^.svn/",
      "^.cache/",
      "^.zsh_sessions/",
      "^Library/",
      "^Movies",
      "^Music",
      "Dropbox/",
      ".DS_Store",
    },
    vimgrep_arguments = {
      -- rgオプション
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "-uu",
    },
    -- layout_config = {
    --   horizontal = {
    --     height = 0.2,
    --   }
    -- },
  },
  pickers = {
    find_files = { theme = "ivy", previewer = false },
    oldfiles = { theme = "ivy", previewer = false },
    live_grep = { theme = "ivy" },
    buffers = { theme = "ivy", previewer = false },
    recent_files = { theme = "ivy", previewer = false },
    grep_string = { theme = "ivy", previewer = false },
    diagnostics = { theme = "ivy", previewer = false },
    current_buffer_fuzzy_find = { theme = "ivy" },
    resume = { theme = "ivy", previewer = false },
    live_grep = { theme = "ivy" },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})
require("telescope").load_extension("fzf")
