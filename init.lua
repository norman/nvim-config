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
  {key = "s", cmd = "set nolist!",   desc = "Toggle invisible characters"},
  {key = "n", cmd = "set nonumber!", desc = "Toggle line numbers"}
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

-- keymaps with leader
for _, t in ipairs(keymaps_with_leader) do
  local key = string.format("<leader>%s", t["key"])
  local command = string.format("<cmd>%s<cr>", t["cmd"])

  vim.keymap.set("n", key, command, {desc = t["desc"]})
end

-- assign main configuration
for name, value in pairs(options) do
  vim.opt[name] = value
end

require("config.lazy")
