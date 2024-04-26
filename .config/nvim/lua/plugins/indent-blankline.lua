-----------------------------------------------------------
-- Indent line configuration file
-----------------------------------------------------------

-- Plugin: indent-blankline
-- url: https://github.com/lukas-reineke/indent-blankline.nvim


local ibl = require('indent_blankline')
if not status_ok then
  return
end

ibl.setup {
  -- Possible chars: ▏┆┊│╎⦚⸾⫶⎜⋮∣⁚˸ː
  char = "⎜",
  context_char = "⁚",
  use_treesitter = true,
  use_treesitter_scope = true,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = true,
  filetype_exclude = {
    'lspinfo',
    'packer',
    'checkhealth',
    'help',
    'man',
    'dashboard',
    'git',
    'markdown',
    'text',
    'terminal',
    'NvimTree',
    'html'
  },
  buftype_exclude = {
    'terminal',
    'nofile',
    'quickfix',
    'prompt',
  },
  context_patterns = {
    "class",
    "^func",
    "method",
    "^if",
    "while",
    "for",
    "with",
    "try",
    "except",
    "arguments",
    "argument_list",
    "object",
    "dictionary",
    "element",
    "table",
    "tuple",
    "do_block",
    "array",
    "statement"
  }
}
