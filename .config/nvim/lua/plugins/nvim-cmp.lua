return {
  {
    "hrsh7th/nvim-cmp",
    -- version = false,
    -- branch = "perf-up",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- "saadparwaiz1/cmp_luasnip",
      -- {
      --   "L3MON4D3/LuaSnip",
      --   dependencies = {
      --     {
      --       "rafamadriz/friendly-snippets",
      --       config = function()
      --         require("luasnip.loaders.from_vscode").lazy_load()
      --       end,
      --     }
      --   },
      -- keys = function() return {} end,
      -- opts = {
      --   history = true,
      --   delete_check_events = "TextChanged",
      -- },
      -- },
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

      -- local luasnip = require("luasnip")
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()

      local lspkind_comparator = function(conf)
        local lsp_types = require('cmp.types').lsp
        return function(entry1, entry2)
          if entry1.source.name ~= 'nvim_lsp' then
            if entry2.source.name == 'nvim_lsp' then
              return false
            else
              return nil
            end
          end
          local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
          local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

          local priority1 = conf.kind_priority[kind1] or 0
          local priority2 = conf.kind_priority[kind2] or 0
          if priority1 == priority2 then
            return nil
          end
          return priority2 < priority1
        end
      end

      local label_comparator = function(entry1, entry2)
        return entry1.completion_item.label < entry2.completion_item.label
      end

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

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
        -- snippet = {
        --   expand = function(args)
        --     luasnip.lsp_expand(args.body)
        --   end
        -- },
        sources = {
          -- { name = "luasnip", priority = 15, max_item_count = 3 },
          {
            name = "copilot",
            group_index = 1,
            priority = 20,
          },
          {
            name = "nvim_lsp",
            priority = 10,
            group_index = 1,
            max_item_count = 50,
            entry_filter = function(entry, ctx)
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
          ['<Tab>'] = function(fallback)
            if not cmp.select_next_item() then
              if vim.bo.buftype ~= 'prompt' and has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end
          end,
          ['<S-Tab>'] = function(fallback)
            if not cmp.select_prev_item() then
              if vim.bo.buftype ~= 'prompt' and has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end
          end,
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        },
        -- sorting = {
        --   comparators = {
        --     cmp.config.compare.exact,
        --     cmp.config.compare.offset,
        --     cmp.config.compare.score,
        --     lspkind_comparator({
        --       kind_priority = {
        --         Variable = 12,
        --         Field = 11,
        --         Property = 11,
        --         Constant = 10,
        --         Enum = 10,
        --         EnumMember = 10,
        --         Event = 10,
        --         Function = 10,
        --         Method = 10,
        --         Operator = 10,
        --         Reference = 10,
        --         Struct = 10,
        --         File = 8,
        --         Folder = 8,
        --         Class = 5,
        --         Color = 5,
        --         Module = 5,
        --         Keyword = 2,
        --         Constructor = 1,
        --         Interface = 1,
        --         Snippet = 0,
        --         Text = -1,
        --         TypeParameter = 1,
        --         Unit = 1,
        --         Value = 1,
        --       },
        --     }),
        --     -- cmp.config.compare.kind,
        --     -- cmp.config.compare.sort_text,
        --     cmp.config.compare.length,
        --     cmp.config.compare.order,
        --     -- label_comparator,
        --   },
        -- },
      }
    end,
    ---@param opts cmp.ConfigSchema | {auto_brackets?: string[]}
    config = function(_, opts)
      local cmp = require("cmp")
      local Kind = cmp.lsp.CompletionItemKind

      cmp.setup(opts)

      -- cmp.event:on("confirm_done", function(event)
      --   if not vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
      --     return
      --   end
      --   local entry = event.entry
      --   local item = entry:get_completion_item()
      --   if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) then
      --     local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
      --     vim.api.nvim_feedkeys(keys, "i", true)
      --   end
      -- end)
    end,
  }
}
