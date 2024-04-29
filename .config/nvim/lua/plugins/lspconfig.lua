return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      diagnostics = {
        update_in_insert = true,
        underline = true,
        signs = false,
        severity_sort = true,
        virtual_text = {
          format = function(d)
            if d.severity == vim.diagnostic.severity.INFO then
              return string.sub(d.message, 1, 25) .. '…'
            end;
            if d.severity == vim.diagnostic.severity.HINT then
              return string.sub(d.message, 1, 25) .. '…'
            end;
            return string.format('%s', d.message)
          end,
          prefix = '▣',
          source = 'if_many',
        },
        float = {
          focusable = false,
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = "",
        },
      },
      capabilities = {},
      servers = {
        'pyright', 'clangd',
        'astro', 'html', 'cssls', 'intelephense', 'vtsls',
        'gopls',
      },
      setup = {
        pyright = {
          settings = {
            python = {
              pythonPath = '/usr/bin/python3.11',
            }
          }
        },
      }
    },
    config = function(_, opts)
      local cmp_nvim_lsp = require('cmp_nvim_lsp')
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

      -- TODO: move autocmd to buffer
      vim.cmd([[
        autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
      ]])

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Highlighting references
        if client.server_capabilities.document_highlight then
          vim.api.nvim_exec([[
          augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
          ]], false)
        end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap = true, silent = true }

        -- TODO: fix keymap
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
      end

      require('lspconfig.ui.windows').default_options.border = 'single'

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
          opts.setup[server] or {}
        )

        require("lspconfig")[server].setup(server_opts)
      end
    end
  }
}
