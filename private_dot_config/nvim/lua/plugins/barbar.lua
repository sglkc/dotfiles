return {
  {
    'romgrk/barbar.nvim',
    event = 'VeryLazy',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons'
    },
    keys = {
      { 'bn', '<cmd>BufferNext<cr>', desc = 'buffer next' },
      { 'bp', '<cmd>BufferPrevious<cr>', desc = 'buffer previous' },
      { 'bd', '<cmd>BufferClose<cr>', desc = 'buffer close' },
      { '<A-Left>', '<cmd>BufferMovePrevious<cr>', desc = 'buffer move left' },
      { '<A-Right>', '<cmd>BufferMoveNext<cr>', desc = 'buffer move right' },
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      animation = true,
      auto_hide = false,
      tab_pages = true,
      closable = true,
      clickable = true,
      -- highlight_alternate = true,
      highlight_visible = true,
      focus_on_close = 'previous',
      maximum_padding = 4,
      minimum_padding = 1,
      maximum_length = 16,
      minimum_length = 5,
      icons = {
        buffer_index = true,
        filetype = { enabled = true },
        -- TODO
        -- gitsigns = {
        --   added = { enabled = true, icon = "" },
        --   changed = { enabled = true, icon = "" },
        --   deleted = { enabled = true, icon = "" },
        -- }
      }
    }
  }
}
