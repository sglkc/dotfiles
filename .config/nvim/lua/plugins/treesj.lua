return {
  'Wansmer/treesj',
  keys = {
    {
      '<leader>o',
      function() require('treesj').toggle() end,
      desc = 'toggle code blocks',
    }
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = { use_default_keymaps = false }
}
