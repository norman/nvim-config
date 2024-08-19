return {
  "neovim/nvim-lspconfig",
  config = function()
    require("lspconfig").solargraph.setup {
      cmd = { os.getenv( "HOME" ) .. "/.rbenv/shims/solargraph", "stdio" },
      autoformat = true
    }
  end
}
