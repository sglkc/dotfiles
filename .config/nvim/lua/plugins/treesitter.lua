return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      'windwp/nvim-ts-autotag',
      'RRethy/nvim-treesitter-endwise',
      'jwalton512/vim-blade',
      -- 'hiphish/rainbow-delimiters.nvim',
      {
        'andymass/vim-matchup',
        lazy = false,
        config = function()
          vim.g.matchup_matchparen_offscreen = { method = 'popup' }
          vim.g.matchup_transmute_enabled = 1 -- html element replace

          vim.g.matchup_delim_noskips = 1
          vim.g.matchup_delim_stopline = 1000 -- 1500
          vim.g.matchup_matchparen_stopline = 200 -- 400

          vim.g.matchup_matchparen_timeout = 100 -- 300
          vim.g.matchup_matchparen_insert_timeout = 60 -- 60

          vim.g.matchup_matchparen_deferred = 1
          vim.g.matchup_matchparen_deferred_show_delay = 50 -- 50
          vim.g.matchup_matchparen_deferred_hide_delay = 300 -- 700
          vim.g.matchup_matchparen_pumvisible = 0
        end
      }
    },
    lazy = true,
    version = false,
    build = ":TSUpdate",
    event = "VeryLazy",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSUninstall" },
    opts = {
      ensure_installed = {
        --[[ "comment", ]] "todotxt",
        "bash",
        "python",
        "html", "javascript", "jsdoc", "css", "typescript",
        "tsx", "astro", "vue",
        "php", "php_only", "phpdoc",
        "sql",
        "json", "jsonc",
        "markdown", "markdown_inline",
        "query",
        "regex",
        "lua",
        "vim", "vimdoc",
        "toml", "yaml",
      },
      sync_install = true,
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 1000 * 1024 -- 3000 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        -- additional_vim_regex_highlighting = true,
      },
      indent = {
        enable = true
      },
      matchup = {
        enable = true
      },
      endwise = {
        enable = true
      }
    },
    config = function(_, opts)
      local parsers = require("nvim-treesitter.parsers").get_parser_configs()
      require("nvim-ts-autotag").setup()
      require("nvim-treesitter.configs").setup(opts)

      parsers.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      vim.filetype.add({ pattern = { [".*%.blade%.php"] = "blade" } })
    end
  }
}
