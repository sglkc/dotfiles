return {
  {
    'romgrk/barbar.nvim',
    event = 'VeryLazy',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'kyazdani42/nvim-web-devicons'
    },
    keys = {
      { 'bn', '<cmd>BufferNext<cr>', 'Next buffer (barbar)' },
      { 'bp', '<cmd>BufferPrevious<cr>', 'Previous buffer (barbar)' },
      { 'bd', '<cmd>BufferClose<cr>', 'Close buffer gracefully (barbar)' },
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
