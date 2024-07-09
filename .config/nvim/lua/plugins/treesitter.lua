return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      'windwp/nvim-ts-autotag',
      'RRethy/nvim-treesitter-endwise',
      -- 'hiphish/rainbow-delimiters.nvim',
      {
        'andymass/vim-matchup',
        lazy = false,
        config = function()
          vim.g.matchup_matchparen_offscreen = { method = 'popup' }
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
          local max_filesize = 3000 * 1024 -- 3000 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      autotag = {
        enable = true,
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
      require("nvim-treesitter.configs").setup(opts)
      require("nvim-treesitter.parsers").get_parser_configs().blade = {
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
