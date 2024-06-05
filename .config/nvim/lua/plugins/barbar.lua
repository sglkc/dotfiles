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
      auto_hide = true,
      tab_pages = true,
      closable = true,
      clickable = true,
      focus_on_close = 'previous',
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
