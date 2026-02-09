return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- main branch (rewrite)
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },

    dependencies = {
      "windwp/nvim-ts-autotag",
      "RRethy/nvim-treesitter-endwise",
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
          multiwindow = true, -- Enable multiwindow support.
          max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 2, -- Maximum number of lines to show for a single context
          trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        }
      },
      -- "jwalton512/vim-blade",
      {
        "andymass/vim-matchup",
        lazy = false,
        config = function()
          vim.g.matchup_matchparen_offscreen = {}
          vim.g.matchup_transmute_enabled = 1
          vim.g.matchup_delim_noskips = 1
          vim.g.matchup_delim_stopline = 1000
          vim.g.matchup_matchparen_stopline = 200
          vim.g.matchup_matchparen_timeout = 100
          vim.g.matchup_matchparen_insert_timeout = 60
          vim.g.matchup_matchparen_deferred = 1
          vim.g.matchup_matchparen_deferred_show_delay = 50
          vim.g.matchup_matchparen_deferred_hide_delay = 300
          vim.g.matchup_matchparen_pumvisible = 0

          local ok, cmp = pcall(require, "cmp")
          if ok then
            cmp.event:on("menu_opened", function()
              vim.b.matchup_matchparen_enabled = false
            end)
            cmp.event:on("menu_closed", function()
              vim.b.matchup_matchparen_enabled = true
            end)
          end
        end,
      },
    },

    opts = {
      ensure_installed = {
        "bash",
        "python",
        "html", "css",
        "javascript", "jsdoc",
        "typescript", "tsx",
        "astro", "vue",
        "php", "phpdoc",
        "sql",
        "json", "json5", "markdown", "markdown_inline",
        "query", "regex",
        "lua", "vim", "vimdoc", "toml", "yaml",
      },
    },

    config = function(_, opts)
      local ts = require("nvim-treesitter")

      -- 1. Install parsers (rewrite API)
      ts.install(opts.ensure_installed)

      -- 2. Blade parser (unchanged, still valid)
      local parsers = require("nvim-treesitter.parsers")
      parsers.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      -- 3. Feature plugins
      require("nvim-ts-autotag").setup()

      -- 4. Treesitter activation (NEW REQUIRED STEP)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
          local buf = args.buf
          local max_filesize = 1000 * 1024 -- ~1MB

          local ok, stat = pcall(
            vim.loop.fs_stat,
            vim.api.nvim_buf_get_name(buf)
          )

          if ok and stat and stat.size > max_filesize then
            return
          end

          pcall(vim.treesitter.start, buf)
        end,
      })
    end,
  },
}

