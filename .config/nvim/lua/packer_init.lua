-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme


-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  -- Add you plugins here:
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- File explorer
  use {
    'kyazdani42/nvim-tree.lua',
  }

  -- Indent line
  use 'lukas-reineke/indent-blankline.nvim'

  -- Autopair
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
    end
  }
  use {
    'windwp/nvim-ts-autotag',
    config = function()
      require'nvim-ts-autotag'.setup{}
    end
  }

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Treesitter interface
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

      parser_config.blade = {
        install_info = {
          url = '~/sources/treesitter/tree-sitter-blade',
          files = {
            'src/parser.c',
            -- 'src/scanner.cc',
          },
          generate_requires_npm = true,
          requires_generate_from_grammar = true,
        },
        filetype = 'blade',
      }
    end,
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        requires = {
          {
            'rafamadriz/friendly-snippets',
            config = function ()
              require('luasnip/loaders/from_vscode').lazy_load({
                paths = {
                  '~/.local/share/nvim/site/pack/packer/start/friendly-snippets',
                }
              })
            end
          }
        }
      },
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
    },
  }

  -- Statusline
  use {
    'feline-nvim/feline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup{}
    end,
  }

  -- Dashboard (start screen)
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- Highlight current window
  -- use 'sunjon/shade.nvim'

  -- Tabline plugin
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function ()
      require'bufferline'.setup({
        animation = true,
        auto_hide = true,
        tab_pages = true,
        closable = true,
        clickable = true,
        icons = { buffer_index = true, filetype = { enabled = true } }
      })
    end
  }

  -- Night owl colorscheme
  -- use 'Julpikar/night-owl.nvim'
  use 'folke/tokyonight.nvim'
  -- use { "catppuccin/nvim", as = "catppuccin" }

  -- Smooth scroll
  use 'karb94/neoscroll.nvim'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Telescope-fzf-native
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- ccc
  --use {
  --  'uga-rosa/ccc.nvim',
  --  config = function ()
  --    local ccc = require('ccc')
  --    ccc.setup({
  --      mappings = {
  --        ['<Esc>'] = ccc.mapping.quit,
  --        ['<Right>'] = ccc.mapping.increase1,
  --        ['<Left>'] = ccc.mapping.decrease1,
  --      }
  --    })
  --  end
  --}

  -- use {
  --   'NvChad/nvim-colorizer.lua',
  --   config = function ()
  --     require'colorizer'.setup({
  --       user_default_options = {
  --         RRGGBBAA = true,
  --         rgb_fn = true,
  --         hsl_fn = true
  --       }
  --     })
  --   end
  -- }

  -- Impatient
  use {
    'lewis6991/impatient.nvim',
    config = function ()
      require'impatient'
    end
  }

  -- React highlighting
  -- use 'MaxMEllon/vim-jsx-pretty'
  -- use 'yuezk/vim-js'

  -- Vue
  -- use 'leafOfTree/vim-vue-plugin'

  -- Astro
  -- use 'elel-dev/vim-astro-syntax'
  -- use 'https://github.com/wuelnerdotexe/vim-astro'

  -- MDX
  --use 'jxnblk/vim-mdx-js'

  -- Tagbar
  --use 'https://github.com/preservim/tagbar'

  -- Matchup
  use {
    'andymass/vim-matchup',
    setup = function ()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end
  }

  -- INDENT
  -- use 'yioneko/nvim-yati'
  --use '2072/PHP-Indenting-for-VIm'
  -- use 'sglkc/vim-blade'
  --use 'captbaritone/better-indent-support-for-php-with-html'

  --AERIAL
  -- use 'stevearc/aerial.nvim'

  -- JAVA
  -- use 'mfussenegger/nvim-jdtls'

  -- SNIPETS
  --use {
  --  'L3MON4D3/LuaSnip',
  --  --config = function ()
  --  --  require('luasnip/loaders/from_vscode').load({
  --  --    paths = {
  --  --      '~/.local/share/nvim/site/pack/packer/start/friendly-snippets',
  --  --    }
  --  --  })
  --  --end
  --}

  --use 'rafamadriz/friendly-snippets'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
