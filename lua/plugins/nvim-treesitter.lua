return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {"ruby", "lua"},
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
      indent = { enable = true },
    })

    vim.api.nvim_set_hl(0, "@comment.ruby", { italic = true, force = true })
  end
}
