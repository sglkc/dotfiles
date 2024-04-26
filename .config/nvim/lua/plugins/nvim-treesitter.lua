-----------------------------------------------------------
-- Treesitter configuration file
----------------------------------------------------------

-- Plugin: nvim-treesitter
-- url: https://github.com/nvim-treesitter/nvim-treesitter


local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

-- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
nvim_treesitter.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    'css', 'html', 'javascript', 'typescript', 'tsx', 'json', 'jsonc', 'jsdoc',
    'php', 'php_only', 'phpdoc', 'sql', 'blade', 'vue',
    'todotxt', 'comment',
    'markdown', 'vim', 'bash',
    'lua', 'python',
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- disable = { 'blade' },
    disable = function(lang, buf)
      -- if lang == 'blade' then return true end
      local max_filesize = 3000 * 1024 -- 3000 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    -- additional_vim_regex_highlighting = { 'sh', 'bash', 'vim' },
  },
  matchup = {
    enable = true,
  },
  autotag = {
    enable = false,-- true
    enable_close_on_slash = true,
    enable_rename = true,
    filetypes = {
      'html', 'xml',
      'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte',
      'vue', 'tsx', 'jsx', 'rescript',
      'php', 'blade',
      'markdown',
      'astro', 'glimmer', 'handlebars', 'hbs'
    },
  },
  indent = {
    enable = true,
    -- disable = {
    --   'blade', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact',
    --   'lua', 'python', 'css', 'html', 'json', 'toml'
    -- }
  },
}

vim.treesitter.language.register('markdown', 'mdx')

--local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
--ft_to_parser.mdx = "markdown"

vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { link = 'Comment' })
