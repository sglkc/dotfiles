return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3M0N4D3/LuaSnip",
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
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
      vim.api.nvim_set_hl(0, 'CmpItemKindFile', { link='CmpItemKindFolder' })
      vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#C099FF' })
      vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
      vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#82AAFF' })
      vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
      vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#89ddff' })
      vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
      vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()

      return {
        auto_brackets = {}, -- configure any filetype to auto add brackets
        completion = {
          completeopt = "menu,menuone,noselect,preview",
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
            luasnip.lsp_expand(args.body)
          end
        },
        sources = {
          { name = "luasnip", priority = 15, max_item_count = 3 },
          { name = "nvim_lsp", priority = 10 },
          { name = "buffer", priority = 3, max_item_count = 3 },
          { name = "path", priority = 1, max_item_count = 3 },
        },
        formatting = {
          fields = {'menu', 'abbr', 'kind'},
          format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            maxwidth = 20,
            ellipsis_char = '…',
            before = function (entry, vim_item)
              local menu_icon = {
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
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      }
    end,
    ---@param opts cmp.ConfigSchema | {auto_brackets?: string[]}
    config = function(_, opts)
      local cmp = require("cmp")
      local Kind = cmp.lsp.CompletionItemKind

      cmp.setup(opts)

      cmp.event:on("confirm_done", function(event)
        if not vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
          return
        end
        local entry = event.entry
        local item = entry:get_completion_item()
        if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) then
          local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
          vim.api.nvim_feedkeys(keys, "i", true)
        end
      end)
    end,
  }
}
