local status_ok, aerial = pcall(require, 'aerial')
if not status_ok then
  return
end

aerial.setup({
  backends = { "lsp", "treesitter", "markdown", "man" },
  layout = {
    min_width = 25
  },
  -- Determines how the aerial window decides which buffer to display symbols for
  --   window - aerial window will display symbols for the buffer in the window from which it was opened
  --   global - aerial window will display symbols for the current window
  attach_mode = "global",

  -- List of enum values that configure when to auto-close the aerial window
  --   unfocus       - close aerial when you leave the original source window
  --   switch_buffer - close aerial when you change buffers in the source window
  --   unsupported   - close aerial when attaching to a buffer that has no symbol source
  close_automatic_events = { 'unsupported' },

  -- Disable aerial on files with this many lines
  disable_max_lines = 1000,

  -- Disable aerial on files this size or larger (in bytes)
  disable_max_size = 500000, -- Default 2MB

  --File = 1;
  --Module = 2;
  --Namespace = 3;
  --Package = 4;
  --Class = 5;
  --Method = 6;
  --Property = 7;
  --Field = 8;
  --Constructor = 9;
  --Enum = 10;
  --Interface = 11;
  --Function = 12;
  --Variable = 13;
  --Constant = 14;
  --String = 15;
  --Number = 16;
  --Boolean = 17;
  --Array = 18;
  --Object = 19;
  --Key = 20;
  --Null = 21;
  --EnumMember = 22;
  --Struct = 23;
  --Event = 24;
  --Operator = 25;
  --TypeParameter = 26;
  filter_kind = {
    'Array',
    'Class',
    'Constructor',
    'Enum',
    'Interface',
    'Module',
    'Struct',
  },
  ignore = {
    filetypes = { 'html' }
  },
  --highlight_on_hover = true,
  highlight_on_jump = 0,
  --autojump = true,
  --open_automatic = true,
  nav = {
    min_width = { 0.5, 50 },
    autojump = true,
    -- preview = true,
  }
})

vim.keymap.set('n', 'fa', extensions.aerial.aerial, {})
vim.keymap.set('n', '<leader>a', extensions.aerial.aerial, {})
vim.keymap.set('n', 'fq', ':AerialToggle<CR>')
vim.keymap.set('n', '<leader>q', ':AerialToggle<CR>')
