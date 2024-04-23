-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------


-- Plugin: nvim-cmp
-- url: https://github.com/hrsh7th/nvim-cmp


local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

local luasnip_status_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_status_ok then
  return
end

-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
vim.api.nvim_set_hl(0, 'CmpItemKindFile', { link='CmpItemKindFolder' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#C099FF' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#82AAFF' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#89ddff' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

cmp.setup {
  -- Load snippet support
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- Completion settings
  completion = {
    --completeopt = 'menuone,longest,preview',
    keyword_length = 2
  },

  -- Key mapping
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    --['<Space>'] = cmp.mapping.close(),

    -- DISABLED BECAUSE PROBLEMATIC
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),

    -- Tab mapping
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end
  },

  -- Coolio
  window = {
    completion = {
      border = 'rounded',
      side_padding = 1,
    },
    documentation = cmp.config.window.bordered(),
  },

  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = require'lspkind'.cmp_format({
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
        vim_item.dup = ({
          luasnip = 0,
          buffer = 0,
          nvim_lsp = 0,
          path = 0,
        })[entry.source.name] or 0

        return vim_item
      end
    })
  },

  experimental = {
    ghost_text = true,
  },

  -- Load sources, see: https://github.com/topics/nvim-cmp
  sources = {
    { name = 'luasnip', priority = 10, max_item_count = 5 },
    { name = 'nvim_lsp', priority = 5 },
    -- { name = 'path', priority = 1, max_item_count = 3 },
    { name = 'buffer', priority = 3, max_item_count = 3 },
  },
}
