local global_options = {
  -- Use comma as the leader for keybindings
  mapleader = ","
}

local options = {
  -- Location of ctags file. Used for basic class/function navigation and
  -- opening files by class or function name with `vim -t`.
  tags = "./tags",

  -- Use line numbers
  number = true,

  -- How many spaces does a tab represent? This should be somewhat
  -- language-dependent but I primarily use Ruby so my default is 2.
  tabstop = 2,

  -- The number of space characters inserted for indentation
  shiftwidth = 2,

  -- Basically make spaces behave like tabs for code indentation
  smarttab = true,

  -- Indent automatically when starting a new line
  smartindent = true,

  -- Insert the configured number of spaces instead of a tab
  expandtab = true
}

local keymaps_with_leader = {
  {keys = "s",  cmd = "set nolist!",   desc = "Toggle invisible characters"},
  {keys = "n",  cmd = "set nonumber!", desc = "Toggle line numbers"},
  {keys = "f",  cmd = "Telescope find_files", desc = "Telescope find files"},
  {keys = "gf", cmd = "Telescope git_files", desc = "Telescope Git files"},
  {keys = "lg", cmd = "Telescope live_grep", desc = "Telescope live grep"},
  {keys = "lr", cmd = "Telescope lsp_references", desc = "Telescope LSP References"}
}

---------------------------------------------------------------
---------------------------------------------------------------
---- No more configuration after this comment, just setup. ----
---------------------------------------------------------------
---------------------------------------------------------------

-- assign global configuration
for name, value in pairs(global_options) do
  vim.g[name] = value
end

-- Load plugins
require("config.lazy")

-- keymaps with leader
for _, t in ipairs(keymaps_with_leader) do
  local keys = string.format("<leader>%s", t["keys"])
  local command = string.format("<cmd>%s<cr>", t["cmd"])

  vim.keymap.set("n", keys, command, {desc = t["desc"]})
end

-- assign main configuration
for name, value in pairs(options) do
  vim.opt[name] = value
end
