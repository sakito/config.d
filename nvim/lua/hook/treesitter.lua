local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "python",
      "typescript",
      "tsx",
      "javascript",
      "html",
      "bash",
      "cmake",
      "css",
      "go",
      "gomod",
      "json",
      "make",
      "markdown",
      "rust",
      "toml",
      "yaml",
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})
