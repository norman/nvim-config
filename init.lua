---------------------------------------------------------------
---------------------------------------------------------------
--- This part of the config should all just be vanilla Lua. ---
---------------------------------------------------------------
---------------------------------------------------------------

local colorscheme = "evening"

local global_options = {
  -- Disable network read/write for VimTree. I don't use it anyway.
  -- anyway.
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,

  -- Use comma as the leader for keybindings
  mapleader = ","
}

local options = {
  -- Insert the configured number of spaces instead of a tab
  expandtab = true,

  -- Use line numbers
  number = true,

  -- The number of space characters inserted for indentation
  shiftwidth = 2,

  -- Indent automatically when starting a new line
  smartindent = true,

  -- Basically make spaces behave like tabs for code indentation
  smarttab = true,

  -- How many spaces does a tab represent? This should be somewhat
  -- language-dependent but I primarily use Ruby so my default is 2.
  tabstop = 2,

  -- Name of ctags file. Used for basic class/function navigation and
  -- opening files by class or function name with `vim -t`. I just generate
  -- tags myself using the command line, there's no automation for that set up.
  tags = "tags"
}

local keymaps_with_leader = {
  { keys = "b",  cmd = "Telescope buffers",        desc = "Telescope buffers" },
  { keys = "d",  cmd = "NvimTreeToggle",           desc = "Toggle file tree" },
  { keys = "F",  cmd = "NvimTreeFindFile",         desc = "Locate file in tree" },
  { keys = "f",  cmd = "Telescope find_files",     desc = "Telescope find files" },
  { keys = "n",  cmd = "set nonumber!",            desc = "Toggle line numbers" },
  { keys = "s",  cmd = "set nolist!",              desc = "Toggle invisible characters" },
  { keys = "x",  cmd = "lua vim.lsp.buf.format()", desc = "LSP Autoformat" },
  { keys = "t",  cmd = "Telescope tags",           desc = "Telescope tags" },
  { keys = "gf", cmd = "Telescope git_files",      desc = "Telescope Git files" },
  { keys = "lg", cmd = "Telescope live_grep",      desc = "Telescope live grep" },
  { keys = "lr", cmd = "Telescope lsp_references", desc = "Telescope LSP References" }
}

---------------------------------------------------------------
---------------------------------------------------------------
---- No more configuration after this comment, just setup. ----
---------------------------------------------------------------
---------------------------------------------------------------
vim.cmd(string.format("colorscheme %s", colorscheme))

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

-- Load plugins using Lazy - https://github.com/folke/lazy.nvim
require("config.lazy")
