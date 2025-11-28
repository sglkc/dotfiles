return {
  {
    'romgrk/barbar.nvim',
    event = 'VeryLazy',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons'
    },
    keys = {
      { 'bn',        vim.cmd.BufferNext,                   desc = 'buffer next' },
      { 'bp',        vim.cmd.BufferPrevious,               desc = 'buffer previous' },
      { 'bd',        vim.cmd.BufferClose,                  desc = 'buffer close' },
      { 'bD',        vim.cmd.BufferCloseAllButVisible,     desc = 'buffer close not visible' },
      { '<C-Tab>',   vim.cmd.BufferNext,                   desc = 'buffer next',             mode = { 'n', 'i', 't' } },
      { '<C-S-Tab>', vim.cmd.BufferPrevious,               desc = 'buffer previous',         mode = { 'n', 'i', 't' } },
      { '<C-w>',     vim.cmd.BufferClose,                  desc = 'buffer close',            mode = 'n' },
      { '<A-Left>',  vim.cmd.BufferMovePrevious,           desc = 'buffer move left' },
      { '<A-Right>', vim.cmd.BufferMoveNext,               desc = 'buffer move right' },
      { '<C-1>',     function() vim.cmd.BufferGoto(1) end, desc = 'go to buffer 1' },
      { '<C-2>',     function() vim.cmd.BufferGoto(2) end, desc = 'go to buffer 2' },
      { '<C-3>',     function() vim.cmd.BufferGoto(3) end, desc = 'go to buffer 3' },
      { '<C-4>',     function() vim.cmd.BufferGoto(4) end, desc = 'go to buffer 4' },
      { '<C-5>',     function() vim.cmd.BufferGoto(5) end, desc = 'go to buffer 5' },
      { '<C-6>',     function() vim.cmd.BufferGoto(6) end, desc = 'go to buffer 6' },
      { '<C-7>',     function() vim.cmd.BufferGoto(7) end, desc = 'go to buffer 7' },
      { '<C-8>',     function() vim.cmd.BufferGoto(8) end, desc = 'go to buffer 8' },
      { '<C-9>',     function() vim.cmd.BufferGoto(9) end, desc = 'go to buffer 9' },
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
