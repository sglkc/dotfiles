return {
  {
    'romgrk/barbar.nvim',
    event = 'VeryLazy',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons'
    },
    keys = function ()
      local goto = function (num) vim.cmd.BufferGoto(num) end
      return {
        { 'bn',        vim.cmd.BufferNext, desc = 'buffer next' },
        { 'bp',        vim.cmd.BufferPrevious, desc = 'buffer previous' },
        { 'bd',        vim.cmd.BufferClose, desc = 'buffer close' },
        { '<C-Tab>',   vim.cmd.BufferNext, desc = 'buffer next',      mode = { 'n', 'i', 't' } },
        { '<C-S-Tab>', vim.cmd.BufferPrevious, desc = 'buffer previous',  mode = { 'n', 'i', 't' } },
        { '<C-w>',     vim.cmd.BufferClose, desc = 'buffer close',     mode = 'n' },
        { '<A-Left>',  vim.cmd.BufferMovePrevious, desc = 'buffer move left' },
        { '<A-Right>', vim.cmd.BufferMoveNext, desc = 'buffer move right' },
        { '<C-1>',     goto(1), desc = 'go to buffer 1' },
        { '<C-2>',     goto(2), desc = 'go to buffer 2' },
        { '<C-3>',     goto(3), desc = 'go to buffer 3' },
        { '<C-4>',     goto(4), desc = 'go to buffer 4' },
        { '<C-5>',     goto(5), desc = 'go to buffer 5' },
        { '<C-6>',     goto(6), desc = 'go to buffer 6' },
        { '<C-7>',     goto(7), desc = 'go to buffer 7' },
        { '<C-8>',     goto(8), desc = 'go to buffer 8' },
        { '<C-9>',     goto(9), desc = 'go to buffer 9' },
      }
    end,
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
