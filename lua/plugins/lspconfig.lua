return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable("ruby_lsp")
    vim.lsp.enable("eslint")
    vim.lsp.enable("html")
    vim.lsp.enable("cssls")
    vim.lsp.enable("lua_ls")

    vim.lsp.config("ruby_lsp", {
      cmd = { "bundle", "exec", "ruby-lsp" },
      diagnostics = true,
      filetypes = { "ruby", "eruby" },
      -- root_markers = { 'Gemfile', '.git' },
      init_options = {
        formatter = "rubocop_internal",
        linters = { "rubocop_internal" },
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

    vim.lsp.config("lua_ls", {
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
            pvim
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
