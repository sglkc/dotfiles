return {
  {
    "neovim/nvim-lspconfig",
    commit = '5408121379b45f7f64626d77f7a62237dadbde82',
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      diagnostics = {
        update_in_insert = true,
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
          linehl = {},
          numhl = {
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
          },
        },
        severity_sort = true,
        virtual_text = {
          format = function(d)
            if d.severity == vim.diagnostic.severity.ERROR then
              return d.message
            end
            return string.sub(d.message, 1, 25) .. '…'
          end,
          prefix = '▣',
          source = 'if_many',
        },
        float = {
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = "",
        },
      },
      capabilities = {},
      servers = {
        'pyright', 'clangd', 'gopls', 'svelte',
        'astro', 'html', 'cssls', 'intelephense',
        'vtsls',
        -- 'tsserver',
        'volar',
        'lua_ls',
      },
      setup = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
              },
              diagnostics = {
                globals = { 'vim' },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        -- pyright = {
        --   settings = {
        --     python = {
        --       pythonPath = '/usr/bin/python3.11',
        --     }
        --   }
        -- },
        intelephense = {
          init_options = {
            globalStoragePath = '/tmp/intelephense'
          }
        },
        volar = {
          init_options = {
            typescript = { tsdk = '/home/sglkc/.local/share/pnpm/global/5/node_modules/typescript/lib' },
            vue = { hybridMode = true }
          }
        },
        vtsls = {
          settings = {
            complete_function_calls = true,
            javascript = {
              suggest = {
                completeFunctionCalls = true,
              },
              experimental = {
                completion = { enableServerSideFuzzyMatch = true }
              },
            },
            typescript = {
              suggest = {
                completeFunctionCalls = true,
              },
              experimental = {
                completion = { enableServerSideFuzzyMatch = true }
              },
            },
            vtsls = {
              autoUseWorkspaceTsdk = true,
              tsserver = {
                globalPlugins = {
                  {
                    name = '@vue/typescript-plugin',
                    location = '/home/sglkc/.local/share/pnpm/global/5/node_modules/@vue/language-server',
                    languages = { 'vue' },
                    configNamespace = 'typescript',
                    enableForWorkspaceTypeScriptVersions = true
                  },
                  {
                    name = 'typescript-svelte-plugin',
                    location = '/home/sglkc/.local/share/pnpm/global/5/node_modules/typescript-svelte-plugin',
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                }
              }
            }
          },
          filetypes = {
            'typescript',
            'javascript',
            'javascriptreact',
            'typescriptreact',
            'vue',
          }
        },
      }
    },
    config = function(_, opts)
      local cmp_nvim_lsp = require('cmp_nvim_lsp')
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

      vim.cmd([[
        autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focusable = false, scope = 'cursor' })
      ]])

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        local function lsp_buf_hover() vim.lsp.buf.hover({ border = "rounded" }) end

        -- Define the LSP actions available in the menu
        -- Each action has a description for the menu and a function to execute
        local lsp_actions = {
          { desc = "1.  Code Action", fn = function() vim.lsp.buf.code_action() end },
          { desc = "2.  Format Buffer/Selection", fn = function() vim.lsp.buf.format() end },
          { desc = "3.  Rename Symbol", fn = function() vim.lsp.buf.rename() end },
          { desc = "4.  Go to Definition", fn = function() vim.lsp.buf.definition() end },
          { desc = "5.  Go to Implementation", fn = function() vim.lsp.buf.implementation() end },
          { desc = "6.  Find References", fn = function() vim.lsp.buf.references() end },
          { desc = "7.  Signature Help", fn = function() vim.lsp.buf.signature_help() end },
          { desc = "8.  Go to Declaration", fn = function() vim.lsp.buf.declaration() end },
          { desc = "9. Go to Type Definition", fn = function() vim.lsp.buf.type_definition() end },
          { desc = "10. Set Diagnostics in Loclist", fn = function() vim.diagnostic.setloclist() end },
          { desc = "11. Go to Previous Diagnostic", fn = function() vim.diagnostic.goto_prev() end },
          { desc = "12. Go to Next Diagnostic", fn = function() vim.diagnostic.goto_next() end },
          -- { desc = "Hover Information", fn = function() lsp_buf_hover() end },
          -- { desc = "Add Workspace Folder", fn = function() vim.lsp.buf.add_workspace_folder() end },
          -- { desc = "Remove Workspace Folder", fn = function() vim.lsp.buf.remove_workspace_folder() end },
          -- { desc = "List Workspace Folders", fn = function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end },
          -- { desc = "13. Show Line Diagnostics", fn = function() vim.diagnostic.open_float(nil, { scope = "line" }) end },
        }

        -- Function to display the LSP action menu
        local function show_lsp_action_menu()
          -- Prepare the list of descriptions for vim.ui.select
          local action_descriptions = {}
          for _, action in ipairs(lsp_actions) do
            table.insert(action_descriptions, action.desc)
          end

          vim.ui.select(action_descriptions, {
            prompt = "LSP Action:", -- Title for the selection menu
            format_item = function(item)
              -- 'item' is the description string itself
              return item
            end,
          }, function(selected_description, index)
              -- This callback function is executed when an item is selected or selection is cancelled

              if selected_description == nil then
                -- User cancelled the selection (e.g., pressed Esc)
                vim.notify("LSP Action selection cancelled.", vim.log.levels.INFO)
                return
              end

              -- 'index' is the 1-based index of the selected item in action_descriptions
              local selected_action = lsp_actions[index]

              if selected_action and selected_action.fn then
                -- Execute the command in a protected call to catch potential errors
                local ok, err = pcall(selected_action.fn)
                if not ok then
                  vim.notify("Error executing LSP action: " .. tostring(selected_action.description) .. "\n" .. tostring(err), vim.log.levels.ERROR)
                end
              else
                vim.notify("Error: Could not find action for '" .. tostring(selected_description) .. "'", vim.log.levels.ERROR)
              end
            end)
        end

        -- Key mapping for <Leader><CR> in normal mode to open the LSP action menu
        vim.keymap.set('n', '<CR>', lsp_buf_hover, {
          noremap = true,
          silent = true,
          desc = 'Open LSP Hover Menu'
        })

        vim.keymap.set('n', '<C-CR>', show_lsp_action_menu, {
          noremap = true,
          silent = true,
          desc = 'Open LSP Action Menu' -- Description for which-key or other plugins
        })

        vim.keymap.set('n', '<Leader><CR>', show_lsp_action_menu, {
          noremap = true,
          silent = true,
          desc = 'Open LSP Action Menu' -- Description for which-key or other plugins
        })

        vim.notify("LSP Action Menu mapped to <Leader><CR>", vim.log.levels.INFO)
      end

      local root_dir = require('lspconfig').util.root_pattern(
        '.git', '.gitignore', 'package.json', 'node_modules', 'composer.json',
        'index.php', 'pubspec.yaml', '.clangd'
      )

      local register_capability = vim.lsp.handlers["client/registerCapability"]

      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        local buffer = vim.api.nvim_get_current_buf()
        on_attach(client, buffer)
        return ret
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local ensure_installed = {}
      for _, server in ipairs(servers) do
        local server_opts = vim.tbl_deep_extend(
          "force",
          {
            on_attach = on_attach,
            root_dir = root_dir,
            capabilities = vim.deepcopy(capabilities),
          },
          opts.setup[server] or {
            single_file_support = false
          }
        )

        require("lspconfig")[server].setup(server_opts)
      end
    end
  }
}
