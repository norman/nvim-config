return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "bash",
        "css",
        "csv",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "ruby",
        "scss",
        "sql",
        "tmux",
        "yaml",
      },
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
      indent = { enable = true },
    })
  end
}
