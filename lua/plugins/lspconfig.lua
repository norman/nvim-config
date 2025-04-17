return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    -- lspconfig.solargraph.setup {
    --   cmd = { os.getenv("HOME") .. "/.rbenv/shims/solargraph", "stdio" },
    --   autoformat = true
    -- }

    lspconfig.ruby_lsp.setup({
      cmd = { "bundle", "exec", "ruby-lsp" },
      diagnostics = true,
      filetypes = { "ruby", "eruby" },
      -- root_markers = { 'Gemfile', '.git' },
      init_options = {
        formatter = "auto",
        linters = { "rubocop" },
        enabledFeatures = {
          codeActions = true,
          codeLens = true,
          completion = true,
          definition = true,
          diagnostics = true,
          documentHighlights = true,
          documentLink = true,
          documentSymbols = true,
          foldingRanges = true,
          formatting = true,
          hover = true,
          inlayHint = true,
          onTypeFormatting = false,
          selectionRanges = true,
          semanticHighlighting = true,
          signatureHelp = true,
          typeHierarchy = true,
          workspaceSymbol = true
        },
        featuresConfiguration = {
          inlayHint = {
            implicitHashValue = true,
            implicitRescue = true
          }
        },
        indexing = {
          excludedPatterns = { "path/to/excluded/file.rb" },
          includedPatterns = { "path/to/included/file.rb" },
          excludedGems = {},
          excludedMagicComments = {}
        },
        experimentalFeaturesEnabled = false
      }
    })

    lspconfig.eslint.setup {}
    lspconfig.html.setup {}
    lspconfig.cssls.setup {}

    lspconfig.lua_ls.setup {
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            -- version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        })
      end,
      settings = {
        Lua = {
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
              quote_style = "double",
              trailing_table_separator = "never"
            }
          }
        }
      }
    }
  end
}
