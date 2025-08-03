return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          }
        },
        keys = function() return {} end,
        opts = {
          history = true,
          delete_check_events = "TextChanged",
        },
      },
      "onsails/lspkind.nvim"
    },
    opts = function()
      vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
      vim.api.nvim_set_hl(0, 'CmpItemKindFile', { link = 'CmpItemKindFolder' })
      vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#C099FF' })
      vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
      vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#82AAFF' })
      vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
      vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#89ddff' })
      vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
      vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      return {
        auto_brackets = {}, -- configure any filetype to auto add brackets
        preselect = cmp.PreselectMode.None,
        performance = {
          debounce = 60,                -- 60
          throttle = 10,                -- 30
          fetching_timeout = 50,        -- 500  -- 100
          confirm_resolve_timeout = 10, -- 80  -- 50
          async_budget = 1,             -- 1
          max_view_entries = 200,       -- 200
        },
        window = {
          completion = {
            border = 'rounded',
            side_padding = 1
          },
          documentation = cmp.config.window.bordered()
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        sources = {
          { name = "copilot", group_index = 1, priority = 20 },
          { name = "luasnip", group_index = 1, priority = 15, max_item_count = 3 },
          {
            name = "nvim_lsp",
            priority = 10,
            group_index = 1,
            max_item_count = 50,
            entry_filter = function(entry, _)
              return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
            end
          },
          { name = "path",   priority = 3, max_item_count = 5, group_index = 2 },
          { name = "buffer", priority = 1, max_item_count = 5, group_index = 2 },
        },
        formatting = {
          fields = { 'menu', 'abbr', 'kind' },
          format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            maxwidth = 20,
            ellipsis_char = '…',
            before = function(entry, vim_item)
              local menu_icon = {
                copilot = '',
                nvim_lsp = 'λ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
              }
              vim_item.menu = menu_icon[entry.source.name]
              return vim_item
            end
          })
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          }),
        },
      }
    end,
  }
}
