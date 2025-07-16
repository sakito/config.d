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
  auto_install = false,
  ignore_install = {},
  highlight = { enable = true },
  indent = { enable = true },
  yagi = {
    enable = true,
    default_fallback = "auto",
    disable = { "python", "c", "cpp" },
  }
})
