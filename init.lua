-- I've tried to isolate calls into NeoVim's APIS below so
-- that this part can be vanilla Lua tables. Some additional
-- configuration happens inside plugins - for example the
-- colorscheme. Take a look at the files in lua/plugins/*.lua
-- for more.

local global_options = {
  -- Disable network read/write for VimTree. I don't use it anyway.
  -- anyway.
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,

  -- Use comma as the leader for keybindings
  mapleader = ","
}

local options = {
  -- Use system clipboard
  clipboard = "unnamed",

  -- Insert the configured number of spaces instead of a tab
  expandtab = true,

  -- Use Treesitter for folding
  foldexpr = "nvim_treesitter#foldexpr()",
  foldmethod = "expr",

  -- Use line numbers
  number = true,

  -- Treesitter will be set up for folding
  foldenable = false,

  -- The number of space characters inserted for indentation
  shiftwidth = 2,

  -- Indent automatically when starting a new line
  smartindent = true,

  -- Basically make spaces behave like tabs for code indentation
  smarttab = true,

  -- Open new splits to the bottom right
  splitbelow = true,
  splitright = true,

  -- How many spaces does a tab represent? This should be somewhat
  -- language-dependent but I primarily use Ruby so my default is 2.
  tabstop = 2,

  -- I set this up ages ago and don't remember why, commenting out.
  -- wildmode = "longest,list:longest"
}

-- Some files don't get the right type assigned automatically, configure
-- them explicitly here.
local filetypes = {
  extension = {
    arb = "ruby"
  },
  filename = {
    Guardfile = "ruby"
  }
}

local keymaps_with_leader = {
  { keys = "b",  cmd = "Telescope buffers",               desc = "Telescope buffers" },
  { keys = "d",  cmd = "NvimTreeToggle",                  desc = "Toggle file tree" },
  { keys = "F",  cmd = "NvimTreeFindFile",                desc = "Locate file in tree" },
  { keys = "f",  cmd = "Telescope find_files",            desc = "Telescope find files" },
  { keys = "n",  cmd = "set nonumber!",                   desc = "Toggle line numbers" },
  { keys = "s",  cmd = "set nolist!",                     desc = "Toggle invisible characters" },
  { keys = "x",  cmd = "lua vim.lsp.buf.format()",        desc = "LSP Autoformat" },
  { keys = "t",  cmd = "Telescope lsp_workspace_symbols", desc = "LSP symbols (like ctags)" },
  { keys = "gf", cmd = "Telescope git_files",             desc = "Telescope Git files" },
  { keys = "lg", cmd = "Telescope live_grep",             desc = "Telescope live grep" },
  { keys = "lr", cmd = "Telescope lsp_references",        desc = "Telescope LSP References" },
  { keys = "ls", cmd = "Telescope lsp_document_symbols",  desc = "Telescope LSP doc symbols" },
  { keys = "N",  cmd = "TestNearest -strategy=neovim",    desc = "Run nearest test" },
  { keys = "T",  cmd = "TestFile -strategy=neovim",       desc = "Run all tests in file" }
}

-- There's no more configuration after this comment, just setup.

-- Assign global configuration
for name, value in pairs(global_options) do
  vim.g[name] = value
end

-- Keymaps with leader
for _, t in ipairs(keymaps_with_leader) do
  local keys = string.format("<leader>%s", t["keys"])
  local command = string.format("<cmd>%s<cr>", t["cmd"])

  vim.keymap.set("n", keys, command, { desc = t["desc"] })
end

-- Assign main configuration
for name, value in pairs(options) do
  vim.opt[name] = value
end

vim.filetype.add(filetypes)

-- Load plugins using Lazy - https://github.com/folke/lazy.nvim
require("config.lazy")
