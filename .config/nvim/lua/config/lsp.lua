-- Configure diagnostic display
vim.diagnostic.config({
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
})

-- Auto-show diagnostics on CursorHold
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "CursorMovedI" },
      scope = "cursor",
    })
  end,
})

-- Set up enhanced capabilities with nvim-cmp if available
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local base_capabilities = vim.lsp.protocol.make_client_capabilities()
local enhanced_capabilities = has_cmp and cmp_nvim_lsp.default_capabilities(base_capabilities) or base_capabilities

-- Global LSP configuration for all servers
vim.lsp.config('*', {
  capabilities = enhanced_capabilities,
  -- root_markers = {
  --   'index.php', 'pubspec.yaml', '.clangd', 'go.mod', 'pyproject.toml',
  --   'LICENSE', 'README.md', 'composer.json',
  --   'package.json', 'node_modules', '.git'
  -- },
})

-- Set up LspAttach autocmd for buffer-local configurations
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach', { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    -- Enable completion if supported
    -- if client:supports_method('textDocument/completion') then
    --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    -- end

    -- Auto-format on save if supported
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('lsp_format', { clear = false }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    -- Highlight hovered symbol
    if client:supports_method('textDocument/documentHighlight') then
      vim.api.nvim_set_hl(args.buf, 'LspReferenceRead', { link = 'Search' })
      vim.api.nvim_set_hl(args.buf, 'LspReferenceText', { link = 'Search' })
      vim.api.nvim_set_hl(args.buf, 'LspReferenceWrite', { link = 'Search' })

      vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
      vim.api.nvim_clear_autocmds({ buffer = args.buf, group = 'lsp_document_highlight' })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = 'lsp_document_highlight',
        buffer = args.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = 'lsp_document_highlight',
        buffer = args.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- Custom LSP action menu (preserving your original functionality)
    local function lsp_buf_hover()
      vim.lsp.buf.hover({ border = "rounded", focusable = false })
    end

    local lsp_actions = {
      { desc = "1.  Code Action",                fn = function() vim.lsp.buf.code_action() end },
      { desc = "2.  Format Buffer/Selection",    fn = function() vim.lsp.buf.format() end },
      { desc = "3.  Rename Symbol",              fn = function() vim.lsp.buf.rename() end },
      { desc = "4.  Go to Definition",           fn = function() vim.lsp.buf.definition() end },
      { desc = "5.  Go to Implementation",       fn = function() vim.lsp.buf.implementation() end },
      { desc = "6.  Find References",            fn = function() vim.lsp.buf.references() end },
      { desc = "7.  Signature Help",             fn = function() vim.lsp.buf.signature_help() end },
      { desc = "8.  Go to Declaration",          fn = function() vim.lsp.buf.declaration() end },
      { desc = "9. Go to Type Definition",       fn = function() vim.lsp.buf.type_definition() end },
      { desc = "10. Set Diagnostics in Loclist", fn = function() vim.diagnostic.setloclist() end },
      { desc = "11. Go to Previous Diagnostic",  fn = function() vim.diagnostic.jump({ count = 1, float = true }) end },
      { desc = "12. Go to Next Diagnostic",      fn = function() vim.diagnostic.jump({ count = -1, float = true }) end },
    }

    local function show_lsp_action_menu()
      local action_descriptions = {}
      for _, action in ipairs(lsp_actions) do
        table.insert(action_descriptions, action.desc)
      end

      vim.ui.select(action_descriptions, {
        prompt = "LSP Action:",
        format_item = function(item)
          return item
        end,
      }, function(selected_description, index)
        if selected_description == nil then
          vim.notify("LSP Action selection cancelled.", vim.log.levels.INFO)
          return
        end

        local selected_action = lsp_actions[index]
        if selected_action and selected_action.fn then
          local ok, err = pcall(selected_action.fn)
          if not ok then
            vim.notify("Error executing LSP action: " .. tostring(selected_action.desc) .. "\n" .. tostring(err),
              vim.log.levels.ERROR)
          end
        else
          vim.notify("Error: Could not find action for '" .. tostring(selected_description) .. "'",
            vim.log.levels.ERROR)
        end
      end)
    end

    -- Buffer-local keymaps (preserving your original bindings)
    vim.keymap.set('n', '<CR>', lsp_buf_hover, {
      buffer = bufnr,
      noremap = true,
      silent = true,
      desc = 'Open LSP Hover Menu'
    })

    vim.keymap.set('n', '<C-CR>', show_lsp_action_menu, {
      buffer = bufnr,
      noremap = true,
      silent = true,
      desc = 'Open LSP Action Menu'
    })

    vim.keymap.set('n', '<Leader><CR>', show_lsp_action_menu, {
      buffer = bufnr,
      noremap = true,
      silent = true,
      desc = 'Open LSP Action Menu'
    })
  end,
})

vim.lsp.config.vtsls.filetypes = { "vue" }
-- Enable all configured servers
local servers = {
  'basedpyright', 'gopls', 'svelte',
  'astro', 'html', 'cssls', 'intelephense',
  'vtsls', 'vue_ls', 'lua_ls',
}

vim.lsp.enable(servers)
