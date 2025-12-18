return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable("ruby_lsp")
    vim.lsp.enable("eslint")
    vim.lsp.enable("html")
    vim.lsp.enable("cssls")
    vim.lsp.enable("lua_ls")

    vim.lsp.config("ruby_lsp", {
      cmd = { "ruby-lsp" },
      diagnostics = true,
      filetypes = { "ruby", "eruby" },
      on_attach = function(client, bufnr)
        vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

        -- The code below applies syntax highlighting hints from the LSP
        -- server. By the time this is applied, we should probably have already
        -- gotten high quality highlighting from Treesitter, but this will
        -- layer in additional highlighting from Ruby LSP which may have
        -- additional information that Treesitter doesn't provide. Note that
        -- this highlighting is quite slow, so having Treesitter load first
        -- makes for a better experience even if it's more work.

        -- Enable document highlights when the cursor is held or moved
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorMoved" }, {
          group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true }),
          callback = function()
            vim.lsp.buf.document_highlight()
          end
        })

        -- Clear the highlights when leaving the buffer or moving the cursor off the symbol
        vim.api.nvim_create_autocmd({ "CursorMoved", "BufLeave" }, {
          group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true }),
          callback = function()
            vim.lsp.buf.clear_references()
          end
        })
      end,
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
        -- enabling this turns on more completion functionality
        experimentalFeaturesEnabled = true,
        addonSettings = {
          ["Ruby LSP Rails"] = {
            enablePendingMigrationsPrompt = false
          }
        }
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
            -- pvim
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths here.
              "${3rd}/luv/library"
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
    })
  end
}
